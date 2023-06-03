local dependencies = {
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  { "folke/neodev.nvim", config = false }, -- setup run in `mudox.lsp.backend.init`

  "mason.nvim",
  { "williamboman/mason-lspconfig.nvim", config = false }, -- setup run in `mudox.lsp.backend.init`

  "hrsh7th/cmp-nvim-lsp",
}

local function config()
  local function setup(name)
    require("mudox.lsp." .. name).setup()
  end

  -- backend
  setup("backend")

  -- frontend
  setup("frontend.diagnostic")
  setup("frontend.formatting")
  setup("frontend.code_navigation")
  setup("frontend.refactoring")
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufRead", "BufNewFile" },
  keys = {
    { "<leader>vL", "<Cmd>LspInfo<Cr>", desc = "LSP Information" },
  },
  dependencies = dependencies,
  config = config,
}
