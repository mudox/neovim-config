local function r(name)
  return require("mudox.plugin.lsp." .. name)
end

-- stylua: ignore start
return {
  r "lsp-config", -- LSP configuration

  r "mason",
  r "null-ls",
  r "lsp-lines",
  r "actions-preview",
  r "glance",
}
-- stylua: ignore end
