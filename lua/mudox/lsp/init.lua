On.very_lazy(function()
  -- stylua: ignore
  vim.lsp.enable {
    -- lua
    "lua_ls",
    -- "emmylua_ls",

    -- data format
    "jsonls",
    "yamlls",

    -- shell
    "nushell",

    -- web
    "emmet_language_server",
    "html",
    "cssls",
    -- "ts_ls", -- managed by `typescript-tools.nvim`
  }

  K.ncmd(K.p"vl", "checkhealth vim.lsp", "LSP information")

  local function setup(name)
    require("mudox.lsp." .. name).setup()
  end

  setup("browsing")
  setup("diagnostic")
  setup("refactoring")
end)
