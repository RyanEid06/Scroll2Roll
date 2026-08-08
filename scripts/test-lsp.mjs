import { spawn } from "node:child_process";
import { readFileSync } from "node:fs";
import { join } from "node:path";
import { pathToFileURL } from "node:url";

const root = process.cwd();
const serverPath = process.env.ROCKET_LANGUAGE_SERVER;
if (!serverPath) {
  throw new Error("Set ROCKET_LANGUAGE_SERVER to the pinned rocket-lsp.exe path");
}

const filePath = join(root, "src", "app", "holdem_view.rocket");
const rootUri = pathToFileURL(root).href;
const uri = pathToFileURL(filePath).href;
const source = readFileSync(filePath, "utf8");
const child = spawn(serverPath, [], { cwd: root, stdio: ["pipe", "pipe", "pipe"] });

let nextId = 1;
let buffer = Buffer.alloc(0);
const pending = new Map();
const notifications = [];
let stderr = "";

function send(message) {
  const json = JSON.stringify(message);
  child.stdin.write(`Content-Length: ${Buffer.byteLength(json)}\r\n\r\n${json}`);
}

function request(method, params) {
  const id = nextId++;
  send({ jsonrpc: "2.0", id, method, params });
  return new Promise((resolve, reject) => {
    const timer = setTimeout(() => {
      pending.delete(id);
      reject(new Error(`Timed out waiting for ${method}`));
    }, 15000);
    pending.set(id, { method, resolve, reject, timer });
  });
}

function handle(message) {
  if (Object.hasOwn(message, "id") && pending.has(message.id)) {
    const item = pending.get(message.id);
    pending.delete(message.id);
    clearTimeout(item.timer);
    if (message.error) {
      item.reject(new Error(`${item.method}: ${JSON.stringify(message.error)}`));
    } else {
      item.resolve(message.result);
    }
    return;
  }
  if (message.method) notifications.push(message);
}

child.stdout.on("data", (chunk) => {
  buffer = Buffer.concat([buffer, chunk]);
  while (true) {
    const headerEnd = buffer.indexOf("\r\n\r\n");
    if (headerEnd < 0) return;
    const header = buffer.subarray(0, headerEnd).toString("ascii");
    const match = /Content-Length:\s*(\d+)/i.exec(header);
    if (!match) throw new Error(`Missing Content-Length in ${header}`);
    const length = Number(match[1]);
    const messageEnd = headerEnd + 4 + length;
    if (buffer.length < messageEnd) return;
    const body = buffer.subarray(headerEnd + 4, messageEnd).toString("utf8");
    buffer = buffer.subarray(messageEnd);
    handle(JSON.parse(body));
  }
});
child.stderr.on("data", (chunk) => { stderr += chunk.toString("utf8"); });

function sleep(milliseconds) {
  return new Promise((resolve) => setTimeout(resolve, milliseconds));
}

try {
  const initialized = await request("initialize", {
    processId: process.pid,
    rootUri,
    capabilities: {
      textDocument: { publishDiagnostics: { relatedInformation: true } }
    },
    workspaceFolders: [{ uri: rootUri, name: "Scroll2Roll" }]
  });
  send({ jsonrpc: "2.0", method: "initialized", params: {} });
  send({
    jsonrpc: "2.0",
    method: "textDocument/didOpen",
    params: {
      textDocument: { uri, languageId: "rocket", version: 1, text: source }
    }
  });
  await sleep(600);

  const symbols = await request("workspace/symbol", { query: "holdem_view" });
  const hover = await request("textDocument/hover", {
    textDocument: { uri }, position: { line: 9, character: 24 }
  });
  const definition = await request("textDocument/definition", {
    textDocument: { uri }, position: { line: 9, character: 24 }
  });
  const completion = await request("textDocument/completion", {
    textDocument: { uri },
    position: { line: 54, character: 20 },
    context: { triggerKind: 1 }
  });
  const semantic = await request("textDocument/semanticTokens/full", {
    textDocument: { uri }
  });

  send({
    jsonrpc: "2.0",
    method: "textDocument/didChange",
    params: {
      textDocument: { uri, version: 2 },
      contentChanges: [{ text: `${source}\n@@@\n` }]
    }
  });
  await sleep(1200);
  const diagnosticNotifications = notifications.filter((item) =>
    item.method === "textDocument/publishDiagnostics" && item.params?.uri === uri
  );
  const lastDiagnostics = diagnosticNotifications.at(-1)?.params?.diagnostics ?? [];
  const completionItems = Array.isArray(completion) ? completion : (completion?.items ?? []);
  const definitions = Array.isArray(definition) ? definition : (definition ? [definition] : []);
  const result = {
    serverName: initialized?.serverInfo?.name ?? "rocket-lsp",
    workspaceSymbols: Array.isArray(symbols) ? symbols.length : 0,
    hoverPresent: Boolean(hover?.contents),
    definitionCount: definitions.length,
    definitionTarget: definitions[0]?.uri ?? definitions[0]?.targetUri ?? null,
    completionItems: completionItems.length,
    semanticTokenIntegers: semantic?.data?.length ?? 0,
    diagnosticNotifications: diagnosticNotifications.length,
    liveDiagnosticCount: lastDiagnostics.length,
    protocolStderr: stderr.trim()
  };
  console.log(JSON.stringify(result, null, 2));

  if (!result.hoverPresent || result.definitionCount < 1 ||
      result.completionItems < 1 || result.semanticTokenIntegers < 1 ||
      result.liveDiagnosticCount < 1 || result.protocolStderr !== "") {
    throw new Error("Rocket LSP acceptance checks did not all pass");
  }

  send({
    jsonrpc: "2.0",
    method: "textDocument/didClose",
    params: { textDocument: { uri } }
  });
  await request("shutdown", null);
  send({ jsonrpc: "2.0", method: "exit", params: null });
  child.stdin.end();
  await new Promise((resolve) => child.once("exit", resolve));
} catch (error) {
  console.error(error.stack || String(error));
  child.kill();
  process.exitCode = 1;
}
