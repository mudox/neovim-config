-- vim: fdm=marker fmr=〈,〉

vim.o.completeopt = "menuone,noselect"

local cmp = require("cmp")
local luasnip = require("luasnip")

-- Source 〈

local sources = {
  -- powerful generic sources
  { name = "nvim_lsp" },
  { name = "cmp_tabnine" },

  -- snippets
  { name = "luasnip" },

  -- neovim lua api
  { name = "nvim_lua" },

  -- basic stuff
  { name = "buffer" },
  { name = "path" },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  sources = cmp.config.sources(
    { { name = "path" } },
    { { name = "cmdline", keyword_pattern = [[\k\+]], keyword_length = 3, max_item_count = 20 } }
  ),
})

-- 〉

-- UI 〈

-- stylua: ignore start
local kind_icons = {
  Text          = " ",
  Method        = "m ",
  Function      = " ",
  Constructor   = " ",
  Field         = " ",
  Variable      = " ",
  Class         = " ",
  Interface     = " ",
  Module        = " ",
  Property      = " ",
  Unit          = " ",
  Value         = " ",
  Enum          = " ",
  Keyword       = " ",
  Snippet       = " ",
  Color         = " ",
  File          = " ",
  Reference     = " ",
  Folder        = " ",
  EnumMember    = " ",
  Constant      = " ",
  Struct        = " ",
  Event         = " ",
  Operator      = " ",
  TypeParameter = " ",
}
-- stylua: ignore end

local formatting = {
  fields = { "kind", "abbr", "menu" },
  format = function(entry, vim_item)
    -- Kind icons
    vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
    -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
    vim_item.menu = ({
      nvim_lsp = "[LSP]",
      nvim_lua = "[Nvim Lua]",
      luasnip = "[Snippet]",
      buffer = "[Buffer]",
      path = "[Path]",
      cmdline = "[Cmdline]",
      cmp_tabnine = "[TabNine]",
    })[entry.source.name]
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

local mapping = {
  -- Menu naviation
  ["<C-k>"] = cmp.mapping.select_prev_item(),
  ["<C-j>"] = cmp.mapping.select_next_item(),
  ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
  ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),

  -- Force trigger completion menu to come up
  ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

  -- Disable Ctrl+Y in completion menu
  ["<C-y>"] = cmp.config.disable, -- Occupied by tmux

  -- Cancel completion
  ["<C-e>"] = cmp.mapping {
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  },

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
