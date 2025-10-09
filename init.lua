vim.loader.enable()
-- https://www.reddit.com/r/neovim/comments/1kcz8un/great_improvements_to_the_cmdline_in_nightly
-- https://github.com/neovim/neovim/pull/27855
require("vim._extui").enable {
  enable = true,
  msg = {
    target = "msg",
  },
}
-- it breaks easy-align

-- Convenient globals
require("mudox.globals")

-- Load plugins
require("mudox.lazy")

-- Colorscheme
local ok, tn = pcall(require, "tokyonight")
if ok then
  tn.load()
end

require("mudox.settings")
require("mudox.autocmds")

-- LSP
require("mudox.lsp")

-- Autocmds & keymaps
if vim.fn.argc(-1) == 0 then
  -- delay loading till `VeryLazy`
  On.very_lazy(function()
    require("mudox.keymaps")
    X.dirop.setup()
  end)
else
  -- load them immediately so they affect the opened buffers
  require("mudox.keymaps")
  X.dirop.setup()
end

-- HACK: swizzle nvim_open_win
X.swizzle_nvim_open_win()
