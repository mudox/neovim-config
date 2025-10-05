local function telescope(hl, c)
  hl.TelescopeNormal = {
    fg = c.fg_dark,
    bg = c.bg_dark1,
  }
  hl.TelescopeBorder = {
    fg = c.bg_dark1,
    bg = c.bg_dark1,
  }

  -- prompt
  local prompt = "#2D3149"
  hl.TelescopePromptNormal = {
    bg = prompt,
  }
  hl.TelescopePromptBorder = {
    bg = prompt,
    fg = prompt,
  }
  hl.TelescopePromptTitle = {
    bg = "#FF966C",
    fg = prompt,
  }

  -- preview
  hl.TelescopePreviewTitle = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
  hl.TelescopePreviewNormal = {
    bg = c.bg_dark,
    fg = c.fg_dark,
  }
  hl.TelescopePreviewBorder = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }

  -- results
  hl.TelescoeResultsTitle = {
    bg = c.bg_dark1,
    fg = c.bg_dark1,
  }
  hl.TelescoeResultsNormal = {
    bg = c.bg_dark1,
    fg = c.fg_dark1,
  }
  hl.TelescoeResultsBorder = {
    bg = c.bg_dark1,
    fg = c.bg_dark1,
  }
end

local function snacks(hl, c)
  -- input
  local input = "#2D3149"
  hl.SnacksPickerInput = {
    bg = input,
  }
  hl.SnacksPickerInputBorder = {
    bg = input,
    fg = input,
  }
  hl.SnacksPickerInputTitle = {
    bg = "#FF966C",
    fg = input,
  }

  -- list
  hl.SnacksPickerPreview = {
    bg = c.bg_dark,
  }
  hl.SnacksPickerPreviewBorder = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
  hl.SnacksPickerPreviewTitle = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }

  -- list
  hl.SnacksPickerList = {
    bg = c.bg_dark1,
  }
  hl.SnacksPickerListBorder = {
    bg = c.bg_dark1,
    fg = c.bg_dark1,
  }
  hl.SnacksPickerListTitle = {
    bg = c.bg_dark1,
    fg = c.bg_dark1,
  }
end

local function trouble(hl, _)
  hl.TroubleNormal = hl.Normal
  hl.TroubleNormalNC = hl.NormalNC
end

local function lightbulb(hl, _)
  hl.LightBulbVirtualText = { fg = "#0db9d7" }
end

local function diagnostic(hl, _)
  local c = require("mudox.ui.color").rainbow
  -- stylua: ignore start
  hl.DiagnosticSignError = { fg = c.red    }
  hl.DiagnosticSignWarn  = { fg = c.violet }
  hl.DiagnosticSignInfo  = { fg = c.yellow  }
  hl.DiagnosticSignHint  = { fg = c.gray   }
  -- stylua: ignore end
end

local function diff(hl, _)
  local s = require("mudox.ui.color").sign
  hl.GitSignsAdd = { fg = s.green }
  hl.GitSignsChange = { fg = s.blue }
  hl.GitSignsUntracked = { fg = s.gray }
end

local function folding(hl, _)
  hl.Folded.bg = "bg"
end

local function winbar(hl, _)
  hl.WinBar = { bg = "bg" }
  hl.WinBarNC = { bg = "bg" }
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

local function multicursor(hl, _)
  hl.MultiCursorCursor = { fg = "#222436", bg = "blue" }
  hl.MultiCursorVisual = { bg = "#888822" }
  hl.MultiCursorDisabledCursor = { fg = "#222436", bg = "gray" }
  hl.MultiCursorDisabledVisual = { bg = "#664422" }
end

local function bufferline(hl, _)
  -- transparent tabline backdrop

  hl.BufferLineFill = { bg = "bg" }

  hl.BufferLineSeparator = { bg = "bg" }

  -- hl.BufferLineBufferVisible = { fg = "bg", bg = "bg" }
  -- hl.BufferLineHint = { fg = "bg", bg = "bg" }

  -- hl.BufferLineGroupSeparator = { bg = "bg" }
  -- hl.BufferLineOffsetSeparator = { bg = "bg" }

  hl.BufferLineTabSeparator = { bg = "bg" }
  -- hl.BufferLineTabSeparatorSelected = { bg = "bg" }

  -- hl.BufferLineIndicatorVisible = { fg = "bg", bg = "bg" }
  hl.BufferLineIndicatorSelected = { bg = "bg" }
end

local function win_separator(hl, c)
  hl.WinSeparator = { fg = c.bg_dark }
end

local function italic_keyword(hl, _)
  for _, name in ipairs { "@keyword.function", "Statement" } do
    hl[name].italic = true
  end
end

local function statusline(hl, _)
  hl.StatusLine.bg = "bg"
  hl.StatusLineNC.bg = "bg"
end

local function tiny_inline_diagnostic(hl, _)
  hl.TinyInlineDiagnosticVirtualTextBg = { bg = "bg" }
end

local function float_win(hl, _)
  hl.MdxFloatFrameNormal = { link = "Normal" }
  hl.MdxFloatFrameBorder = { fg = hl.FloatBorder.fg, bg = hl.Normal.bg }

  hl.MdxFloatBlockNormal = { bg = "bg" }
  hl.MdxFloatBlockBorder = { bg = "bg" }
end

local function on_highlights(...)
  local hl, _ = ...

  float_win(...)

  telescope(...)
  snacks(...)

  -- diagnostic(...)
  folding(...)
  diff(...)
  winbar(...)
  -- notify(...)
  trouble(...)
  lightbulb(...)
  multicursor(...)
  bufferline(...)
  win_separator(...)
  italic_keyword(...)
  -- statusline(...)
  tiny_inline_diagnostic(...)

  -- alalcritty
  if U.in_alacritty() then
    local bg = hl.Normal.bg
    for _, v in pairs(hl) do
      if v.bg == bg or v.bg == "bg" then
        v.bg = "NONE"
      end
    end
  end
end

local opts = {
  -- HACK: For transparent background to take effect, the style name here must be same as that
  -- applied to current terminal app (e.g. in kitty.conf)
  style = "moon",

  styles = {
    -- comments = { italic = false },
    keywords = { italic = true },
    sidebars = "transparent",
    floats = "dark",
  },

  lualine_bold = false,

  on_highlights = on_highlights,

  plugins = {
    bufferline = true,
  },
}

return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = opts,
}
