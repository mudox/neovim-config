-- stylua: ignore
_G.C = {
  -- noice.nvim cause vim-visual-multi failed to load
  noice = false, -- noice      | builtin

  -- snacks dashboard is not faster than alpha
  alpha = true,  -- alpha.nvim | snacks.dashboard
}

-- Dev, debug
_G.D = {
  dd = function(...)
    Snacks.debug.inspect(...)
  end,
  bt = function()
    Snacks.debug.backtrace()
  end,
}

---Utility lib
_G.U = require("mudox.util")

---Autocmd helpers
_G.On = require("mudox.util.on")

---Experiment features
_G.X = require("mudox.lab")

---Keymap helpers
_G.K = require("mudox.util.keymap")

---Symbols
_G.I = require("mudox.ui.icon")

_G.Log = function(subsystem)
  return require("plenary.log").new {
    plugin = subsystem,
    use_console = false,
    level = "trace",
  }
end
