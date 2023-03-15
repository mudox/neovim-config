-- It is used in `plugin/config/lsp`

return function(client, bufnr)
  require("mudox.lsp.highlight_cursor")(client, bufnr)
  require("mudox.lsp.mappings")(bufnr)
  require("mudox.lsp.formatting").on_save(client, bufnr)

  require("aerial").on_attach(client, bufnr)
end
