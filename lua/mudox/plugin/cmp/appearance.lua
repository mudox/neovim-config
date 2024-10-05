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

local function format(entry, item)
  local _item = require("nvim-highlight-colors").format(entry, { kind = item.kind })

  item = (require("lspkind").cmp_format {
    mode = "symbol",
    maxwidth = function()
      return math.max(20, math.floor(vim.o.columns * 0.45))
    end,
    ellipsis_char = "...",
  })(entry, item)

  if _item.abbr_hl_group then
    item.kind_hl_group = _item.abbr_hl_group
    item.kind = _item.abbr
  end

  menu(entry, item)

  return item
end
--   local icons = require("mudox.ui.icon").kind
--   item.kind = icons[item.kind] or item.kind
--
--   local menu = ({
--     nvim_lsp = "LSP",
--     luasnip = "SNIPPET",
--     buffer = "BUFFER",
--     path = "PATH",
--     nvim_lua = "NVIM",
--     cmp_tabnine = "TABNINE",
--     rg = "RG",
--     cmdline = "CMD",
--     cmdline_history = "HISTORY",
--   })[entry.source.name:lower()] or entry.source.name:upper()
--
--   item.menu = ("[%s]"):format(menu)
--
--   return item
-- end

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
