local function telescope(hl, c)
  hl.TelescopeNormal = {
    bg = c.bg_dark,
    fg = c.fg_dark,
  }
  hl.TelescopeBorder = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }

  -- prompt
  local prompt = "#2d3149"
  hl.TelescopePromptNormal = {
    bg = prompt,
  }
  hl.TelescopePromptBorder = {
    bg = prompt,
    fg = prompt,
  }
  hl.TelescopePromptTitle = {
    bg = prompt,
    fg = prompt,
  }

  -- preview
  hl.TelescopePreviewTitle = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }

  -- results
  hl.TelescopeResultsTitle = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
end

---@diagnostic disable-next-line: unused-local
local function diagnostic(hl, c)
  local s = require("mudox.ui.color").sign
  hl.DiagnosticSignError = { fg = s.red }
  hl.DiagnosticSignWarn = { fg = s.violet }
  hl.DiagnosticSignDebug = { fg = s.blue }
  hl.DiagnosticSignInfo = { fg = s.green }
  hl.DiagnosticSignHint = { fg = s.gray }
end

---@diagnostic disable-next-line: unused-local
local function gitsigns(hl, c)
  local s = require("mudox.ui.color").sign
  hl.GitSignsAdd = { fg = s.green }
  hl.GitSignsChange = { fg = s.blue }
  hl.GitSignsUntracked = { fg = s.gray }
end

---@diagnostic disable-next-line: unused-local
local function folding(hl, c)
  hl.Folded.bg = "NONE"
end

---@diagnostic disable-next-line: unused-local
local function winbar(hl, c)
  hl.WinBar = { bg = "NONE" }
  hl.WinBarNC = { bg = "NONE" }
end

local function nvim_tree(hl, c)
  hl.NvimTreeOpenedFile.fg = "#FFFFFF"
end

local function dropbar(hl, c)
  -- TRACK: track: https://github.com/Bekaboo/dropbar.nvim/issues/118
  hl.StatusLine = { fg = "white", bg = "NONE" }
  hl.StatusLineNC = { fg = "#828bb8", bg = "NONE" }
end

local opts = {
  -- For transparent background to take effect, the style name here must be same as that
  -- applied to current terminal app (e.g. in kitty.conf)
  style = "moon",

  styles = {
    sidebars = "transparent",
    floats = "dark",
  },

  on_highlights = function(...)
    diagnostic(...)
    folding(...)
    gitsigns(...)
    nvim_tree(...)
    telescope(...)
    dropbar(...)
    winbar(...)
  end,
}

return {
  "folke/tokyonight.nvim",
  opts = opts,
}
