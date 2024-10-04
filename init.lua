-- Globals

---mudox.util
U = require("mudox.util")
---mudox.lab
X = require("mudox.lab")
---mudox.util.keymap
K = U.keymap

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

      X.dirop.setup()
    end,
  })
else
  -- load them immediately so they affect the opened buffers
  U.load("autocmds")
  U.load("keymaps")
end

U.on("UIEnter", function()
  require("tokyonight").load()
end)

-- HACK: swizzle nvim_open_win
X.swizzle()
