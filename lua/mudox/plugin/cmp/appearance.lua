local M = {}

local function menu(entry, item)
  -- stylua: ignore
  local text = ({
    buffer             = "BUF",
    cmdline            = "CMD",
    cmdline_history    = "HIST",
    cmp_tabnine        = "TABN",
    lsp_signature_help = "SIG",
    luasnip            = "SNIP",
    nvim_lsp           = "LSP",
    nvim_lua           = "NVIM",
    path               = "PATH",
    rg                 = "RG",
  })[entry.source.name:lower()] or entry.source.name:upper()

  item.menu = ("%s"):format(text)
end

-- nvim-highlight-colors
local function highlight_colors(entry, item)
  local _item = require("nvim-highlight-colors").format(entry, { kind = item.kind })
  if _item.abbr_hl_group then
    item.kind_hl_group = _item.abbr_hl_group
    item.kind = _item.abbr
  end
end

-- nvim-web-devicons
local function devicon(entry, item)
  if vim.tbl_contains({ "path" }, entry.source.name) then
    local icon, hl = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
    if icon then
      item.kind = icon
      item.kind_hl_group = hl
    end
  end
end

local function format(entry, item)
  item = (require("lspkind").cmp_format {
    mode = "symbol",
    preset = "codicons",
    maxwidth = function()
      return math.max(20, math.floor(vim.o.columns * 0.45))
    end,
    ellipsis_char = "...",
  })(entry, item)

  devicon(entry, item)
  highlight_colors(entry, item)
  menu(entry, item)

  item.kind = " " .. item.kind .. "  "
  return item
end

function M.hightlight()
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
    vim.api.nvim_set_hl(0, k, v)
  end
end

-- see: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
M.formatting = {
  fields = { "kind", "abbr", "menu" },
  format = format,
}

M.view = {
  entries = {
    name = "custom", -- for highlights
    selection_order = "near_cursor",
    follow_cursor = true,
  },
}

M.window = {
  completion = {
    winblend = 0,
    col_offset = -3,
    side_padding = 0,
  },
  documentation = {
    winblend = 0,
  },
}

local function highlights()
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
    vim.api.nvim_set_hl(0, k, v)
  end
end

return M
