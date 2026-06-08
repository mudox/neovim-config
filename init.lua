vim.loader.enable()

-- extui
require("vim._core.ui2").enable {
  enable = true,
  msg = {
    targets = {
      [""] = "msg",
      empty = "cmd",
      bufwrite = "msg",
      confirm = "cmd",
      emsg = "pager",
      echo = "msg",
      echomsg = "msg",
      echoerr = "pager",
      completion = "cmd",
      list_cmd = "pager",
      lua_error = "pager",
      lua_print = "msg",
      progress = "pager",
      rpc_error = "pager",
      quickfix = "msg",
      search_cmd = "cmd",
      search_count = "cmd",
      shell_cmd = "pager",
      shell_err = "pager",
      shell_out = "pager",
      shell_ret = "msg",
      undo = "msg",
      verbose = "pager",
      wildlist = "cmd",
      wmsg = "msg",
      typed_cmd = "cmd",
    },
    msg = {
      height = 0.3,
      timeout = 6000,
    },
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
