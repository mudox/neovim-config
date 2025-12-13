On.VeryLazy(function()
  -- stylua: ignore
  vim.lsp.enable {
    -- lua
    "lua_ls",
    -- "emmylua_ls", -- diagnostic feature weak

    -- data format
    "jsonls",
    "yamlls",
    "taplo", -- toml

    -- shell
    "nushell",

    -- web
    "emmet_language_server",
    "html",
    "cssls",

    -- javascript, typescript
    "tsgo",
  }

  K.ncmd(K.p("vl"), "checkhealth vim.lsp", "lsp information")

  require("mudox.lsp.browsing")
  require("mudox.lsp.diagnostic")
  require("mudox.lsp.refactoring")
end)

On.LspAttach(function(_, bufnr)
  vim.lsp.document_color.enable(false, bufnr)
end)

vim.lsp.semantic_tokens.enable(false)
