-- Luarocks
---@diagnostic disable-next-line: lowercase-global
pl = require("mudox.luarocks")

-- Mode
---@diagnostic disable-next-line: lowercase-global
md = require("mudox.mode")

-- Lazy
require("mudox.lazy")

-- Settings
local load = require("mudox.util.load")
load("settings")

-- Autocmds & Keymaps
if vim.fn.argc(-1) == 0 then
  -- delay loading till `VeryLazy`
  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("LazyVim", { clear = true }),
    pattern = "VeryLazy",
    callback = function()
      load("autocmds")
      load("keymaps")
    end,
  })
else
  -- load them immediately so they affect the opened buffers
  load("autocmds")
  load("keymaps")
end
