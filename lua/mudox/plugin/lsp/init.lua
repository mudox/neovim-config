local function r(name)
  return require("mudox.plugin.lsp." .. name)
end

return {
  r "lsp-config", -- LSP configuration

  r "mason",
  r "null-ls",
  r "lsp-lines",
  r "actions-preview",
}
