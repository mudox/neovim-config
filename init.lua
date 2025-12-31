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

-- HACK: swizzle nvim_open_win
X.swizzle_nvim_open_win:start()

On.VeryLazy(function()
  require("mudox.keymaps")

  X.arrows.init()
  X.files:init()
  X.xpress.init()
end)

require("tokyonight").load()

-- X.log_kautocmds:start()
