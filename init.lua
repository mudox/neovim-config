vim.loader.enable()

-- extui
require("vim._extui").enable {
  enable = true,
  msg = {
    target = "msg",
    timeout = 6000,
  },
}

require("mudox.globals")
require("mudox.lazy")
require("mudox.settings")
require("mudox.autocmds")
require("mudox.lsp")

On.VeryLazy(function()
  require("mudox.keymaps")
  X.arrows.setup()
end)

-- HACK: swizzle nvim_open_win
X.swizzle_nvim_open_win()

-- DO NOT ues event earlier than UIEnter
-- event `TermOpen` will not be triggered
On.UIEnter(function()
  require("mudox.lab.xpress")
  X.files:init()
end)

On.VimEnter(function()
  require("tokyonight").load()
end)
