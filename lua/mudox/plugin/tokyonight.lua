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
  hl.TelescoeResultsTitle = {
    bg = c.bg_dark,
    fg = c.bg_dark,
  }
end

local function trouble(hl, c)
  hl.TroubleNormal = hl.Normal
  hl.TroubleNormalNC = hl.NormalNC
end

local function lightbulb(hl, c)
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
  -- hl.NvimTreeOpenedFile.fg = "#FFFFFF"
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
  -- transparent tabline backdrop
  hl.BufferLineFill = { bg = "bg" }
  hl.BufferLineSeparator = { fg = "bg" }
  hl.BufferLineTabSeparator = { fg = "bg" }
  hl.BufferLineTabSeparatorSelected = { fg = "bg" }
end

local function cmp(hl, c)
  -- stylua: ignore
  local hls = {
    PmenuSel                 = { bg = "#282C34", fg = "NONE" },
    Pmenu                    = { fg = "#C5CDD9", bg = "#22252A" },

    CmpItemAbbrDeprecated    = { fg = "#7E8294", bg = "NONE",      strikethrough = true },
    CmpItemAbbrMatch         = { fg = "#82AAFF", bg = "NONE",      bold          = true },
    CmpItemAbbrMatchFuzzy    = { fg = "#82AAFF", bg = "NONE",      bold          = true },
    CmpItemMenu              = { fg = "#C792EA", bg = "NONE",      italic        = true },

    CmpItemKindField         = { fg = "#EED8DA", bg = "#B5585F" },
    CmpItemKindProperty      = { fg = "#EED8DA", bg = "#B5585F" },
    CmpItemKindEvent         = { fg = "#EED8DA", bg = "#B5585F" },

    CmpItemKindText          = { fg = "#C3E88D", bg = "#9FBD73" },
    CmpItemKindEnum          = { fg = "#C3E88D", bg = "#9FBD73" },
    CmpItemKindKeyword       = { fg = "#C3E88D", bg = "#9FBD73" },

    CmpItemKindConstant      = { fg = "#FFE082", bg = "#D4BB6C" },
    CmpItemKindConstructor   = { fg = "#FFE082", bg = "#D4BB6C" },
    CmpItemKindReference     = { fg = "#FFE082", bg = "#D4BB6C" },

    CmpItemKindFunction      = { fg = "#EADFF0", bg = "#A377BF" },
    CmpItemKindStruct        = { fg = "#EADFF0", bg = "#A377BF" },
    CmpItemKindClass         = { fg = "#EADFF0", bg = "#A377BF" },
    CmpItemKindModule        = { fg = "#EADFF0", bg = "#A377BF" },
    CmpItemKindOperator      = { fg = "#EADFF0", bg = "#A377BF" },

    CmpItemKindVariable      = { fg = "#C5CDD9", bg = "#7E8294" },
    CmpItemKindFile          = { fg = "#C5CDD9", bg = "#7E8294" },

    CmpItemKindUnit          = { fg = "#F5EBD9", bg = "#D4A959" },
    CmpItemKindSnippet       = { fg = "#F5EBD9", bg = "#D4A959" },
    CmpItemKindFolder        = { fg = "#F5EBD9", bg = "#D4A959" },

    CmpItemKindMethod        = { fg = "#DDE5F5", bg = "#6C8ED4" },
    CmpItemKindValue         = { fg = "#DDE5F5", bg = "#6C8ED4" },
    CmpItemKindEnumMember    = { fg = "#DDE5F5", bg = "#6C8ED4" },

    CmpItemKindInterface     = { fg = "#D8EEEB", bg = "#58B5A8" },
    CmpItemKindColor         = { fg = "#D8EEEB", bg = "#58B5A8" },
    CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
  }

  for k, v in pairs(hls) do
    hl.k = v
  end
end

local function on_highlights(...)
  -- diagnostic(...)
  folding(...)
  -- gitsigns(...)
  nvim_tree(...)
  telescope(...)
  winbar(...)
  -- notify(...)
  trouble(...)
  lightbulb(...)
  multicursor(...)
  bufferline(...)
  cmp(...)
end

local opts = {
  -- For transparent background to take effect, the style name here must be same as that
  -- applied to current terminal app (e.g. in kitty.conf)
  style = "moon",

  styles = {
    comments = { italic = false },
    keywords = { italic = false },
    sidebars = "transparent",
    floats = "dark",
  },

  on_highlights = on_highlights,
}

return {
  "folke/tokyonight.nvim",
  -- lazy = false,
  -- priority = 1000,
  opts = opts,
}
