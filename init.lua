vim.loader.enable()

-- Convenient globals
require("mudox.globals")

-- Neovim mode - g:mdx_nvim_mode
require("mudox.mode")

-- Plugin manager - lazy.nvim
require("mudox.lazy")

-- Colorscheme
require("tokyonight").load()

U.load("settings")
U.load("autocmds")

-- LSP
require("mudox.lsp")

-- Autocmds & keymaps
if vim.fn.argc(-1) == 0 then
  -- delay loading till `VeryLazy`
  On.very_lazy(function()
    U.load("keymaps")
    X.dirop.setup()
  end)
else
  -- load them immediately so they affect the opened buffers
  U.load("keymaps")
  X.dirop.setup()
end

-- HACK: swizzle nvim_open_win
X.swizzle_nvim_open_win()
