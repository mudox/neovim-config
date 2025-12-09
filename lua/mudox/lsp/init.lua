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

    "tsgo",
  }

  K.ncmd(K.p("vl"), "checkhealth vim.lsp", "lsp information")

  require("mudox.lsp.browsing")
  require("mudox.lsp.diagnostic")
  require("mudox.lsp.refactoring")
end)

-- disable semantic token globally
-- On.LspAttach(function(client, _)
--   client.server_capabilities.semanticTokensProvider = nil
-- end)
vim.lsp.semantic_tokens.enable(false)
