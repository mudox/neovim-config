local function telescope(hl, c)
  hl.TelescopeNormal = {
    fg = c.fg_dark,
    bg = c.bg_dark,
  }
  hl.TelescopeBorder = {
    fg = c.bg_dark,
    bg = c.bg_dark,
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

local function diagnostic(hl, _)
  local s = require("mudox.ui.color").sign
  -- stylua: ignore start
  hl.DiagnosticSignError = { fg = s.red    }
  hl.DiagnosticSignWarn  = { fg = s.violet }
  hl.DiagnosticSignDebug = { fg = s.blue   }
  hl.DiagnosticSignInfo  = { fg = s.green  }
  hl.DiagnosticSignHint  = { fg = s.gray   }
  -- stylua: ignore end
end

local function gitsigns(hl, _)
  local s = require("mudox.ui.color").sign
  hl.GitSignsAdd = { fg = s.green }
  hl.GitSignsChange = { fg = s.blue }
  hl.GitSignsUntracked = { fg = s.gray }
end

local function folding(hl, _)
  hl.Folded.bg = "NONE"
end

local function winbar(hl, _)
  hl.WinBar = { bg = "NONE" }
  hl.WinBarNC = { bg = "NONE" }
end

local function nvim_tree(hl, _)
  hl.NvimTreeOpenedFile.fg = "#FFFFFF"
end

local function dropbar(hl, _)
  -- TRACK: track: https://github.com/Bekaboo/dropbar.nvim/issues/118
  hl.StatusLine = { fg = "white", bg = "NONE" }
  hl.StatusLineNC = { fg = "#828bb8", bg = "NONE" }
end

local function notify(hl, _)
  local fg = "white"
  local bg = "#990000"

  -- stylua: ignore start
  -- error
  hl.NotifyERRORBody   = { fg = fg, bg = bg }
  hl.NotifyERRORTitle  = { fg = fg, bg = bg }
  hl.NotifyERRORIcon   = { fg = fg, bg = bg }
  hl.NotifyERRORBorder = { fg = bg, bg = bg }

  -- warn
  bg = "#ffc777"
  hl.NotifyWARNBody    = { fg = fg, bg = bg }
  hl.NotifyWARNTitle   = { fg = fg, bg = bg }
  hl.NotifyWARNIcon    = { fg = fg, bg = bg }
  hl.NotifyWARNBorder  = { fg = bg, bg = bg }

  -- info
  bg = "#0db9d7"
  hl.NotifyINFOBody    = { fg = fg, bg = bg }
  hl.NotifyINFOTitle   = { fg = fg, bg = bg }
  hl.NotifyINFOIcon    = { fg = fg, bg = bg }
  hl.NotifyINFOBorder  = { fg = bg, bg = bg }
  -- stylua: ignore end
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
    -- gitsigns(...)
    nvim_tree(...)
    telescope(...)
    dropbar(...)
    winbar(...)
    -- notify(...)
  end,
}

return {
  "folke/tokyonight.nvim",
  opts = opts,
}
