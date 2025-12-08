-- global data vault
_G.V = {
  ag = setmetatable({}, {
    __index = function(self, name)
      local group = vim.api.nvim_create_augroup("mdx." .. name, { clear = true })
      self[name] = group
      return group
    end,
  }), -- augroups
  noice = false,
  ufo = true,
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
