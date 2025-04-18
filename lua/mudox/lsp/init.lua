On.very_lazy(function()
  vim.lsp.enable { "lua_ls", "jsonls", "yamlls" }

  K.ncmd("<leader>vl", "checkhealth vim.lsp", "LSP information")

  local function setup(name)
    require("mudox.lsp." .. name).setup()
  end

  setup("browsing")
  setup("diagnostic")
  setup("refactoring")
end)
