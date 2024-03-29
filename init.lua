-- Globals

---mudox.util
U = require("mudox.util")
---mudox.lab
X = require("mudox.lab")
---mudox.util.keymap
K = U.keymap

X.dirop.setup()

-- Neovim mode - g:mdx_nvim_mode
require("mudox.mode")

-- Plugin manager - lazy.nvim
require("mudox.lazy")

-- Settings
U.load("settings")

-- Autocmds & keymaps
if vim.fn.argc(-1) == 0 then
  -- delay loading till `VeryLazy`
  U.on("User", {
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
