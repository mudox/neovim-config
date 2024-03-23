local dependencies = {
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",
  "antoinemadec/FixCursorHold.nvim",

  -- language bindings
  "nvim-neotest/neotest-jest", -- JavaScript, TypeScript
  "nvim-neotest/neotest-plenary", -- Neovim lua
  "nvim-neotest/neotest-python",
  "rouge8/neotest-rust",

  "vim-test/vim-test",
  "nvim-neotest/neotest-vim-test", -- for those do not have adapters
}

local function opts()
  return {
    adapters = {
      require("neotest-jest"),
      require("neotest-plenary"),
      require("neotest-python"),
      require("neotest-rust"),
    },
    floating = {
      border = require("mudox.ui.icon").border.corner,
    },
    consumers = {
      overseer = require("neotest.consumers.overseer"),
    },
  }
end

return {
  "nvim-neotest/neotest",
  dependencies = dependencies,
  opts = opts,
  keys = require("mudox.plugin.test.keymaps"),
}
