local picker_input = "#2D3149"
local picker_title = "#FF966C"
-- picker results list
-- picker preview

local function telescope(hl, c)
  hl.TelescopeNormal = {
    fg = c.fg_dark,
    bg = c.bg_dark1,
  }
  hl.TelescopeBorder = {
    fg = c.bg_dark1,
    bg = c.bg_dark1,
  }

  -- input
  hl.TelescopePromptBorder = {
    bg = picker_input,
    fg = picker_input,
  }
  hl.TelescopePromptTitle = {
    fg = picker_input,
    bg = picker_title,
  }
  hl.TelescopePromptNormal = {
    bg = picker_input,
  }

  -- preview
  hl.TelescopePreviewTitle = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
  hl.TelescopePreviewBorder = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
  hl.TelescopePreviewNormal = {
    bg = c.bg_dark,
    fg = c.fg_dark,
  }

  -- results
  hl.TelescoeResultsTitle = {
    bg = c.bg_dark1,
    fg = c.bg_dark1,
  }
  hl.TelescoeResultsBorder = {
    bg = c.bg_dark1,
    fg = c.bg_dark1,
  }
  hl.TelescoeResultsNormal = {
    bg = c.bg_dark1,
    fg = c.fg_dark1,
  }
end

local function snacks(hl, c)
  -- input
  hl.SnacksPickerInput = {
    bg = picker_input,
  }
  hl.SnacksPickerInputBorder = {
    bg = picker_input,
    fg = picker_input,
  }
  hl.SnacksPickerInputTitle = {
    fg = picker_input,
    bg = picker_title,
  }

  -- preview
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

local function fzflua(hl, c)
  -- input

  -- preview
  hl.FzfLuaPreviewNormal = {
    bg = c.bg_dark1,
  }
  hl.FzfLuaPreviewBorder = {
    bg = c.bg_dark1,
    fg = c.bg_dark1,
  }
  hl.FzfLuaPreviewTitle = {
    bg = c.bg_dark1,
    fg = c.bg_dark1,
  }

  -- main
  hl.FzfLuaNormal = {
    bg = c.bg_dark,
  }
  hl.FzfLuaFzfNormal = {
    bg = c.bg_dark,
  }
  hl.FzfLuaBorder = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
  hl.FzfLuaTitle = {
    fg = picker_input,
    bg = picker_title,
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

local function bufferline(hl, c)
  local on = c.bg_dark1
  local off = c.bg_dark

  hl.TabLine = { bg = "bg" }
  hl.TabLineSel = { bg = on }

  hl.BufferLineFill = { bg = "bg" } -- transparent

  hl.BufferLineSeparator = { bg = "bg" } -- hide
  hl.BufferLineTabSeparator = { bg = "bg" } -- hide

  hl.BufferLineIndicatorSelected = { bg = "bg" } -- hide

  hl.BufferLineTabSelected = { fg = "white", bg = "bg" }
end

local function win_separator(hl, c)
  hl.WinSeparator = { fg = c.bg_dark }
end

local function italic_keyword(hl, _)
  for _, name in ipairs { "@keyword.function", "Statement" } do
    hl[name].italic = true
  end
end

local function tiny_inline_diagnostic(hl, _)
  hl.TinyInlineDiagnosticVirtualTextBg = { bg = "bg" }
end

local function mudox(hl, c)
  hl._F = { link = "Normal" }
  hl._FBorder = { fg = hl.FloatBorder.fg, bg = hl.Normal.bg }

  hl._B = { bg = c.bg_dark }
  hl._BBorder = { fg = c.bg_dark, bg = c.bg_dark }

  hl._term_winbar_item = { fg = "grey", bg = "#043c38" }
  hl._term_winbar_item_selected = { fg = "white", bg = "#096a62" }
end

local function on_highlights(...)
  local hl, _ = ...

  fzflua(...)
  -- diagnostic(...)
  -- notify(...)
  -- statusline(...)
  bufferline(...)
  diff(...)
  mudox(...)
  folding(...)
  italic_keyword(...)
  lightbulb(...)
  multicursor(...)
  snacks(...)
  telescope(...)
  tiny_inline_diagnostic(...)
  trouble(...)
  win_separator(...)
  winbar(...)

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
