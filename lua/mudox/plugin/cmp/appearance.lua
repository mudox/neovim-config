local M = {}

local function menu(entry, item)
  -- stylua: ignore
  local text = ({
    nvim_lsp        = "LSP",
    luasnip         = "SNIPPET",
    buffer          = "BUFFER",
    path            = "PATH",
    nvim_lua        = "NVIM",
    cmp_tabnine     = "TABNINE",
    rg              = "RG",
    cmdline         = "CMD",
    cmdline_history = "HISTORY",
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

  return item
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
  },
  documentation = {
    winblend = 0,
  },
}

return M
