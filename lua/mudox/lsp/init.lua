On.very_lazy(function()
  -- stylua: ignore
  vim.lsp.enable {
    -- "lua_ls",
    "emmylua_ls",

    "jsonls",
    "yamlls",

    "nushell",
  }

  K.ncmd("<leader>vl", "checkhealth vim.lsp", "LSP information")

  local function setup(name)
    require("mudox.lsp." .. name).setup()
  end

  setup("browsing")
  setup("diagnostic")
  setup("refactoring")
end)
