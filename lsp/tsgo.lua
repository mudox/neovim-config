return {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  root_markers = {
    "tsconfig.base.json",
    "tsconfig.json",
    "jsconfig.json",
    "package.json",
    ".git",
  },
  cmd = { "tsgo", "lsp", "--stdio" },
}
