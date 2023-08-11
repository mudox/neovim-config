local M = {}

local function format(entry, item)
  local icons = require("mudox.ui").icons.kind
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

-- HACK: disable blending to avoid kitty icon size inconsistency
vim.o.pumblend = 0

M.view = {
  entries = { name = "custom", selection_order = "near_cursor" },
}

return M
