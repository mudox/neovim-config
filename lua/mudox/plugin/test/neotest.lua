local dependencies = {
  -- required
  "nvim-neotest/nvim-nio",
  "nvim-lua/plenary.nvim",
  "antoinemadec/FixCursorHold.nvim",
  "nvim-treesitter/nvim-treesitter",

  -- language bindings
  "nvim-neotest/neotest-jest", -- JavaScript, TypeScript
  "nvim-neotest/neotest-plenary", -- Neovim lua
  "nvim-neotest/neotest-python",
  "rouge8/neotest-rust",

  -- for those languages that do not have corresponding neotest adapters
  "vim-test/vim-test",
  "nvim-neotest/neotest-vim-test",
}

local function opts()
  return {
    adapters = {
      require("neotest-plenary"),
      require("neotest-jest"),
      require("neotest-python"),
      require("neotest-rust"),
      require("rustaceanvim.neotest"),
    },
    floating = {
      border = I.border.corner,
    },
    consumers = {
      overseer = require("neotest.consumers.overseer"),
    },
    icons = {
      passed = I.check,
      failed = I.ballot,
    },
  }
end

return {
  "nvim-neotest/neotest",
  dependencies = dependencies,
  opts = opts,
  keys = require("mudox.plugin.test.keymaps"),
}
