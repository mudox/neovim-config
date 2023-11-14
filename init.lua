-- Globals
U = require("mudox.util")
K = U.keymap

require("mudox.lab.renav").setup()

-- Lazy
require("mudox.lazy")

-- Settings
U.load("settings")

-- Autocmds & Keymaps
if vim.fn.argc(-1) == 0 then
  -- delay loading till `VeryLazy`
  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
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
