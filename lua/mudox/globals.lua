-- stylua: ignore
_G.C = {
  -- ISSUE: noice.nvim cause vim-visual-multi failed to load
  noice = false, -- noice      | builtin
  blink = true,  -- blink.cmp  | nvim-cmp
  -- snacks dashboard is not faster than alpha
  alpha = true,  -- alpha.nvim | snacks.dashboard

  key = {
    toggle  = "<C-x>",
  }
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

---Logging
---@param name string number of subsystem, also the filename
_G.Log = function(name)
  if not package.loaded["plenary.log"] then
    vim.opt.rtp:append("~/.local/share/nvim/lazy/plenary.nvim")
  end
  return package.loaded["plenary.log"].new {
    plugin = name,
    use_console = false,
    level = "debug",
  }
end
