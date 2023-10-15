local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return function()
  -- NOTE: see https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings
  -- for examples

  local cmp = require("cmp")

  -- local luasnip = require("luasnip")

  return cmp.mapping.preset.insert {
    -- ["<C-n>"] trigger completion or select next item
    -- ["<C-p>"] trigger completion or select previous item

    -- documentation window scrolling
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),

    -- ["<C-Space>"] = false,
    ["<C-e>"] = cmp.mapping.abort(), -- abort

    -- Enter
    -- - if nothing is selected (including preselections) add a newline as usual.
    -- - if something has explicitly been selected by the user, select it.
    -- see: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#safely-select-entries-with-cr
    ["<Cr>"] = cmp.mapping {
      i = function(fallback)
        if cmp.visible() and cmp.get_active_entry() then
          cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
        else
          fallback()
        end
      end,
      s = cmp.mapping.confirm { select = true },
      c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
    },

    -- Tab
    -- select next cmp item -> trigger completion before word -> fallback
    -- see: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping
    -- - use <C-f|b> to jump between snippet placeholders
    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --     -- you could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
    --     -- this way you will only jump inside the snippet region
    --   elseif has_words_before() then
    --     cmp.complete()
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }
end
