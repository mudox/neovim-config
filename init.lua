-- Globals
U = require("mudox.util")
X = require("mudox.lab")
K = U.keymap

X.renav.setup()

-- Neovim mode
require("mudox.mode")

-- Plugin manager
require("mudox.lazy")

-- Settings
U.load("settings")

-- Autocmds & keymaps
if vim.fn.argc(-1) == 0 then
  -- delay loading till `VeryLazy`
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      U.load("autocmds")
      U.load("keymaps")
    end,
  })
else
  -- load them immediately so they affect the opened buffers
  U.load("autocmds")
  U.load("keymaps")
end

local a = 1
