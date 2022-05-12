-- vim: fdm=marker fmr=〈,〉

vim.o.completeopt = "menuone,noselect"

local cmp = require("cmp")
local luasnip = require("luasnip")

-- Source 〈

local sources = {
  -- Lauange syntax
  { name = "nvim_lsp", max_item_count = 20 },
  { name = "treesitter" },

  -- Lua
  { name = "nvim_lua", max_item_count = 10 },
  { name = "nvim_lsp_signature_help" },

  -- Tokens from opened buffers
  { name = "buffer" },

  -- File sytem path
  { name = "path" },

  -- LuaSnip snippets
  { name = "luasnip" },

  -- Npm
  { name = "npm", keyword_length = 3 },

  -- TabNine AI completion engine
  { name = "cmp_tabnine", max_item_count = 10 },

  -- Source from `rg`
  { name = "rg", max_item_count = 10 },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
for _, mode in ipairs { "/", "?" } do
  cmp.setup.cmdline(mode, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "cmdline_history", max_item_count = 20 },
      { name = "buffer", keyword_length = 3, max_item_count = 30 },
    },
  })
end

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "cmdline_history", max_item_count = 20 },
    { name = "cmdline", keyword_length = 3, max_item_count = 30 },
    { name = "path" },
  },
})

-- 〉

-- UI 〈

local kind_icons = require("mudox.ui").icons.lsp.kind

local function menu_name(key)
  -- stylua: ignore start
  local map = {
    nvim_lsp        = "[LSP]",
    nvim_lua        = "[Nvim Lua]",
    luasnip         = "[LuaSnip]",
    buffer          = "[Buffer]",
    path            = "[Path]",
    cmdline         = "[Cmdline]",
    cmp_tabnine     = "[TabNine]",
    treesitter      = "[TeeSitter]",
    rg              = "[RG]",
    cmdline_history = "[History]",
  }
  -- stylua: ignore end

  return map[key] or key
end

local formatting = {
  fields = { "kind", "abbr", "menu" },
  format = function(entry, vim_item)
    -- Kind icons
    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
    -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
    vim_item.menu = menu_name(entry.source.name)
    return vim_item
  end,
}

-- 〉

-- Mapping 〈

--- Return `true` if
--    - cursor is in the first column of the line
--    - character before cursor is white space
local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local mapping = cmp.mapping.preset.insert {

  -- Menu naviation
  ["<C-p>"] = cmp.mapping.select_prev_item(),
  ["<C-n>"] = cmp.mapping.select_next_item(),

  ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  ["<C-f>"] = cmp.mapping.scroll_docs(4),

  -- Force trigger completion menu to come up
  ["<C-Space>"] = cmp.mapping.complete(),

  -- Disable Ctrl+Y in completion menu
  ["<C-y>"] = cmp.config.disable, -- Occupied by tmux

  -- Cancel completion
  ["<C-e>"] = cmp.mapping.abort(),
  -- ["<C-e>"] = cmp.mapping {
  --   i = cmp.mapping.abort(),
  --   c = cmp.mapping.close(),
  -- },

  -- Accept currently selected item. If none selected, `select` first item.
  -- Set `select` to `false` to only confirm explicitly selected items.
  ["<CR>"] = cmp.mapping.confirm { select = true },

  -- The super tab
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expandable() then
      luasnip.expand()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif check_backspace() then
      fallback()
    else
      fallback()
    end
  end, {
    "i",
    "s",
  }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, {
    "i",
    "s",
  }),
}

-- 〉

-- Snippet 〈
local snippet = {
  expand = function(args)
    -- use `LuaSnip`
    luasnip.lsp_expand(args.body)
  end,
}
-- 〉

cmp.setup {
  sources = sources,
  mapping = mapping,
  formatting = formatting,
  snippet = snippet,
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
}
