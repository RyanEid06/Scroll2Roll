# Third-party notices

The packaged application statically links raylib 6.0, copyright 2013-2026 Ramon
Santamaria and contributors, under the zlib/libpng license. The packaging script
copies the complete pinned upstream `LICENSE` file into the Windows bundle as
`RAYLIB_LICENSE.txt`.

Pinned source: `https://github.com/raysan5/raylib/tree/6.0`

No downloaded raylib source, compiled dependency, generated binding, or package
artifact is committed to this repository.

The application bundles the unmodified Manrope variable font and a locally
generated static Medium instance, Copyright 2018/2019 The Manrope Project
Authors, under the SIL Open Font License 1.1. The static instance is derived
only by pinning the source font's `wght` axis to 500 with FontTools 4.59.0 so
raylib can render the intended production weight. The exact files, `OFL.txt`,
upstream metadata, derivation, source URLs, retrieval date, and SHA-256 values
are recorded in `assets/MANIFEST.md`. The license file must ship beside every
package containing the font. Scroll2Roll does not imply endorsement by the
Manrope authors, Google Fonts, or FontTools.

The two Scroll2Roll cover atlases are original owner-commissioned ImageGen
outputs and contain no third-party reference image input. Their exact prompts,
generation identifiers, review notes, and SHA-256 values are preserved under
`assets/ui/IMAGEGEN_PROMPTS.md` and `assets/MANIFEST.md`.
