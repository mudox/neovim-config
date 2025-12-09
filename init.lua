vim.loader.enable()

-- https://www.reddit.com/r/neovim/comments/1kcz8un/great_improvements_to_the_cmdline_in_nightly
-- https://github.com/neovim/neovim/pull/27855
require("vim._extui").enable {
  enable = true,
  msg = {
    target = "msg",
    timeout = 6000,
  },
}

-- Globals
require("mudox.globals")

-- Load plugins
require("mudox.lazy")

-- Colorscheme
local ok, theme = pcall(require, "tokyonight")
if ok then
  theme.load()
end

require("mudox.settings")
require("mudox.autocmds")

-- LSP
require("mudox.lsp")

-- Keymaps ...
-- if vim.fn.argc(-1) == 0 then
-- delay loading till `VeryLazy`
On.VeryLazy(function()
  require("mudox.keymaps")
  X.arrows.setup()
end)
-- else
--   -- load them immediately so they affect the opened buffers
--   require("mudox.keymaps")
--   X.arrows.setup()
-- end

-- HACK: swizzle nvim_open_win
X.swizzle_nvim_open_win()
