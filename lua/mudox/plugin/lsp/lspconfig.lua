local dependencies = {
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  { "folke/neodev.nvim", config = false }, -- setup run in `mudox.lsp.backend.init`

  "mason.nvim",
  { "williamboman/mason-lspconfig.nvim", config = false }, -- setup run in `mudox.lsp.backend.init`

  "hrsh7th/cmp-nvim-lsp", -- for composing base lsp capabilities
}

local function config()
  local function setup(name)
    require("mudox.lsp." .. name).setup()
  end

  -- backend
  setup("backend")

  -- frontend
  setup("frontend.browsing")
  setup("frontend.diagnostic")
  setup("frontend.refactoring")
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufRead", "BufNewFile" },
  keys = {
    { "<leader>vl", "<Cmd>LspInfo<Cr>", desc = "LSP information" },
  },
  dependencies = dependencies,
  config = config,
}
