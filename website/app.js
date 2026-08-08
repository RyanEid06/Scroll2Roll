(() => {
  "use strict";

  const STORAGE_KEY = "scroll2roll.localProfile.v1";
  const MAX_AVATAR_BYTES = 1572864;
  const MAX_NAME_LENGTH = 24;
  const VALID_MIME_TYPES = new Set(["image/png", "image/jpeg", "image/webp"]);
  const NAME_PATTERN = /^[\p{L}\p{N}][\p{L}\p{N} _.'’\-]*$/u;

  const page = document.documentElement.dataset.page;
  let pendingAvatar = null;
  let removeExistingAvatar = false;

  function readProfile() {
    try {
      const parsed = JSON.parse(localStorage.getItem(STORAGE_KEY));
      if (!parsed || parsed.version !== 1 || typeof parsed.nickname !== "string") return null;
      const nameResult = validateNickname(parsed.nickname);
      if (nameResult) return null;
      if (parsed.avatar !== null && typeof parsed.avatar !== "string") return null;
      if (parsed.avatar && !/^data:image\/(png|jpeg|webp);base64,/i.test(parsed.avatar)) return null;
      return { version: 1, nickname: parsed.nickname, avatar: parsed.avatar || null };
    } catch (_) {
      return null;
    }
  }

  function writeProfile(profile) {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(profile));
  }

  function validateNickname(value) {
    const nickname = value.trim().replace(/\s+/g, " ");
    const length = Array.from(nickname).length;
    if (length < 2) return "Enter at least 2 characters.";
    if (length > MAX_NAME_LENGTH) return "Keep your display name to 24 characters or fewer.";
    if (!NAME_PATTERN.test(nickname)) return "Use letters, numbers, spaces, apostrophes, periods, underscores, or hyphens only.";
    return "";
  }

  function initials(name) {
    const parts = name.trim().split(/\s+/).filter(Boolean);
    return (parts.slice(0, 2).map((part) => Array.from(part)[0]).join("") || "S2").toLocaleUpperCase();
  }

  function showAvatar(container, image, fallback, profile) {
    if (!container || !image || !fallback) return;
    if (profile && profile.avatar) {
      image.src = profile.avatar;
      image.hidden = false;
      fallback.hidden = true;
      image.addEventListener("error", () => {
        image.removeAttribute("src");
        image.hidden = true;
        fallback.hidden = false;
      }, { once: true });
    } else {
      image.removeAttribute("src");
      image.hidden = true;
      fallback.hidden = false;
      fallback.textContent = initials(profile ? profile.nickname : "S2");
    }
  }

  function fileSignatureMatches(bytes, mime) {
    if (mime === "image/png") return bytes.length >= 8 && [137,80,78,71,13,10,26,10].every((value, index) => bytes[index] === value);
    if (mime === "image/jpeg") return bytes.length >= 3 && bytes[0] === 255 && bytes[1] === 216 && bytes[2] === 255;
    if (mime === "image/webp") return bytes.length >= 12 && String.fromCharCode(...bytes.slice(0, 4)) === "RIFF" && String.fromCharCode(...bytes.slice(8, 12)) === "WEBP";
    return false;
  }

  function decodeImage(dataUrl) {
    return new Promise((resolve, reject) => {
      const image = new Image();
      image.onload = () => image.naturalWidth > 0 && image.naturalHeight > 0 ? resolve() : reject(new Error("Image dimensions are invalid."));
      image.onerror = () => reject(new Error("The selected file could not be decoded as an image."));
      image.src = dataUrl;
    });
  }

  function readDataUrl(file) {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.onload = () => resolve(String(reader.result));
      reader.onerror = () => reject(new Error("The selected image could not be read."));
      reader.readAsDataURL(file);
    });
  }

  function resetProfile() {
    localStorage.removeItem(STORAGE_KEY);
    window.location.replace("index.html");
  }

  function hydrateAuthenticatedPage(profile) {
    if (!profile) {
      window.location.replace("index.html");
      return;
    }
    document.querySelectorAll("[data-profile-name]").forEach((element) => { element.textContent = profile.nickname; });
    document.querySelectorAll("[data-profile-avatar]").forEach((container) => {
      showAvatar(container, container.querySelector("img"), container.querySelector("span"), profile);
    });
    document.querySelectorAll("[data-reset-profile]").forEach((button) => button.addEventListener("click", resetProfile));
  }

  function initProfilePage(profile) {
    const query = new URLSearchParams(window.location.search);
    if (profile && !query.has("edit")) {
      window.location.replace("play.html");
      return;
    }

    const form = document.getElementById("profile-form");
    const nickname = document.getElementById("nickname");
    const nicknameError = document.getElementById("nickname-error");
    const avatarInput = document.getElementById("avatar-input");
    const avatarError = document.getElementById("avatar-error");
    const avatarPreview = document.querySelector("[data-avatar-preview]");
    const avatarImage = document.querySelector("[data-avatar-image]");
    const avatarFallback = document.querySelector("[data-avatar-fallback]");
    const avatarAction = document.querySelector("[data-avatar-action]");
    const removeAvatar = document.getElementById("remove-avatar");
    const submit = document.getElementById("profile-submit");
    const continueButton = document.getElementById("continue-profile");
    const resetButton = document.querySelector("[data-reset-profile]");
    const status = document.getElementById("profile-status");
    const count = document.getElementById("name-count");

    if (profile) {
      nickname.value = profile.nickname;
      submit.firstChild.textContent = "Save Profile ";
      continueButton.hidden = false;
      resetButton.hidden = false;
      removeAvatar.hidden = !profile.avatar;
      avatarAction.textContent = profile.avatar ? "Replace image" : "Choose image";
    }
    showAvatar(avatarPreview, avatarImage, avatarFallback, profile);

    function updateCount() {
      count.textContent = `${Array.from(nickname.value).length} / ${MAX_NAME_LENGTH}`;
    }
    updateCount();

    nickname.addEventListener("input", () => {
      updateCount();
      nickname.removeAttribute("aria-invalid");
      nicknameError.textContent = "";
      if (!avatarImage.src) avatarFallback.textContent = initials(nickname.value || "S2");
    });

    avatarInput.addEventListener("change", async () => {
      avatarError.textContent = "";
      const file = avatarInput.files && avatarInput.files[0];
      if (!file) return;
      if (!VALID_MIME_TYPES.has(file.type)) {
        avatarError.textContent = "Choose a PNG, JPEG, or WebP image.";
        avatarInput.value = "";
        return;
      }
      if (file.size <= 0 || file.size > MAX_AVATAR_BYTES) {
        avatarError.textContent = "Choose an image no larger than 1.5 MiB.";
        avatarInput.value = "";
        return;
      }
      try {
        const bytes = new Uint8Array(await file.slice(0, 16).arrayBuffer());
        if (!fileSignatureMatches(bytes, file.type)) throw new Error("The file contents do not match its image type.");
        const dataUrl = await readDataUrl(file);
        await decodeImage(dataUrl);
        pendingAvatar = dataUrl;
        removeExistingAvatar = false;
        showAvatar(avatarPreview, avatarImage, avatarFallback, { nickname: nickname.value || "S2", avatar: dataUrl });
        avatarAction.textContent = "Replace image";
        removeAvatar.hidden = false;
      } catch (error) {
        avatarError.textContent = error instanceof Error ? error.message : "The selected image is invalid or corrupt.";
        avatarInput.value = "";
      }
    });

    removeAvatar.addEventListener("click", () => {
      pendingAvatar = null;
      removeExistingAvatar = true;
      avatarInput.value = "";
      showAvatar(avatarPreview, avatarImage, avatarFallback, { nickname: nickname.value || "S2", avatar: null });
      avatarAction.textContent = "Choose image";
      removeAvatar.hidden = true;
      avatarError.textContent = "Profile picture removed. Save the profile to keep this change.";
    });

    form.addEventListener("submit", (event) => {
      event.preventDefault();
      status.textContent = "";
      const cleanedName = nickname.value.trim().replace(/\s+/g, " ");
      const validationMessage = validateNickname(cleanedName);
      if (validationMessage) {
        nickname.setAttribute("aria-invalid", "true");
        nicknameError.textContent = validationMessage;
        nickname.focus();
        return;
      }
      const avatar = removeExistingAvatar ? null : pendingAvatar || (profile ? profile.avatar : null);
      try {
        writeProfile({ version: 1, nickname: cleanedName, avatar });
        status.textContent = "Local profile saved. Opening the game catalog…";
        window.location.assign("play.html");
      } catch (_) {
        status.textContent = "This browser could not save the profile. Remove the avatar or check browser storage settings.";
      }
    });

    continueButton.addEventListener("click", () => window.location.assign("play.html"));
    resetButton.addEventListener("click", resetProfile);
  }

  const profile = readProfile();
  if (page === "profile") initProfilePage(profile);
  if (page === "play" || page === "download") hydrateAuthenticatedPage(profile);
})();
