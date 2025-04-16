local function r(name)
  return require("mudox.plugin.lsp." .. name)
end

-- stylua: ignore
return {
  r"neoconf",
  r"lspconfig",

  r"mason",
  r"null-ls",
  r"actions-preview",
  r"glance",
  r"lightbulb",
  r"garbage-day",
}
