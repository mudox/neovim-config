local function r(name)
  return require("mudox.plugin.lsp." .. name)
end

return {
  r("lspconfig"),

  r("mason"),
  r("null-ls"),
  r("lsp-lines"),
  r("actions-preview"),
  r("glance"),
  r("lightbulb"),
  r("garbage-day"),
}
