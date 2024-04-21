local M = {}

local function format(entry, item)
  local icons = require("mudox.ui.icon").kind
  item.kind = icons[item.kind] or item.kind

  local menu = ({
    nvim_lsp = "LSP",
    luasnip = "SNIPPET",
    buffer = "BUFFER",
    path = "PATH",
    nvim_lua = "NVIM",
    cmp_tabnine = "TABNINE",
    rg = "RG",
    cmdline = "CMD",
    cmdline_history = "HISTORY",
  })[entry.source.name:lower()] or entry.source.name:upper()

  item.menu = ("[%s]"):format(menu)

  return item
end

-- see: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
M.formatting = {
  fields = { "kind", "abbr", "menu" },
  format = format,
}

M.view = {
  entries = {
    name = "custom",
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
