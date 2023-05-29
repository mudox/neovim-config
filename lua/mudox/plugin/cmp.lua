-- vim: fdm=marker fmr=〈,〉

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- mapping 〈

local function mapping()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  return cmp.mapping.preset.insert {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },

    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),

    -- trigger completion menu
    ["<C-Space>"] = cmp.mapping.complete(),
    -- dismiss completion menu without selection
    ["<C-e>"] = cmp.mapping.abort(),

    -- safely select entries with <CR>
    -- - if nothing is selected (including preselections) add a newline as usual.
    -- - if something has explicitly been selected by the user, select it.
    -- see: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#safely-select-entries-with-cr
    ["<CR>"] = cmp.mapping {
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

    -- the super tab
    -- select next item -> expand or jump snippet -> trigger completion before word -> fallback
    -- see: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping
    -- IDEA: remap snippet jumping to <M-[|]>?
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- you could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- they way you will only jump inside the snippet region
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }
end

-- mapping 〉

-- sources 〈

-- see: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
local function sources()
  return {
    -- LSP & TreeSitter
    { name = "nvim_lsp", max_item_count = 8 },
    { name = "nvim_lsp_signature_help" },
    { name = "treesitter" },

    -- tokens from opened buffers
    { name = "buffer", keyword_length = 2 },

    -- file system paths
    { name = "path", keyword_length = 2 },

    -- LuaSnip snippets
    { name = "luasnip", keyword_length = 2 },

    -- TabNine AI completion engine
    { name = "cmp_tabnine", max_item_count = 10 },

    -- source from `rg`
    { name = "rg", max_item_count = 10 },

    -- ISSUE: https://github.com/hrsh7th/nvim-cmp/issues/1594
    --
    -- words
    {
      name = "look",
      keyword_length = 2,
      option = {
        convert_case = true,
        loud = true,
        dict = "/usr/share/dict/words",
      },
    },

    -- lua
    { name = "nvim_lua", max_item_count = 10 }, -- Neovim Lua API

    -- tag closing
    { name = "nvim-cmp-ts-tag-close" },
  }
end

-- sources 〉

-- see: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
local function formatting()
  return {
    fields = { "kind", "abbr", "menu" },

    format = function(entry, item)
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
    end,
  }

  -- fancy formatting
  -- see: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-get-types-on-the-left-and-offset-the-menu
  -- return {
  --   window = {
  --     completion = {
  --       winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
  --       col_offset = -3,
  --       side_padding = 0,
  --     },
  --   },
  --   formatting = {
  --     fields = { "kind", "abbr", "menu" },
  --     format = function(entry, vim_item)
  --       local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
  --       local strings = vim.split(kind.kind, "%s", { trimempty = true })
  --       kind.kind = " " .. (strings[1] or "") .. " "
  --       kind.menu = "    (" .. (strings[2] or "") .. ")"
  --
  --       return kind
  --     end,
  --   },
  -- }
end

local function config()
  local cmp = require("cmp")

  local opts = {
    completion = {
      completeopt = "menu,menuone,noinsert,noselect",
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = mapping(),
    sources = sources(),
    view = {
      entries = { name = "custom", selection_order = "near_cursor" }, -- can be "custom", "wildmenu" or "native" (experimental)
    },
    formatting = formatting(),
    experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
    },
  }

  cmp.setup(opts)

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer", keyword_length = 2 },
      { name = "cmdline_history", keyword_length = 2 },
    },
  })

  -- Use cmdline & path sources for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "path", keyword_length = 2 },
      { name = "cmdline_history", keyword_length = 2 },
      { name = "cmdline", keyword_length = 2 },
    },
  })
end

local dependencies = {
  -- Basics
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-cmdline",
  "dmitmel/cmp-cmdline-history",
  "hrsh7th/cmp-path",

  -- Snippet
  "saadparwaiz1/cmp_luasnip",

  -- LSP
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lsp-signature-help",

  -- TreeSitter
  "ray-x/cmp-treesitter",

  -- rg
  "lukas-reineke/cmp-rg",

  -- AI
  { "tzachar/cmp-tabnine", build = "./install.sh" },

  -- Language specific
  "octaltree/cmp-look",
  "hrsh7th/cmp-nvim-lua",
  "buschco/nvim-cmp-ts-tag-close",

  -- Icons
  "onsails/lspkind.nvim",
}

return {
  "hrsh7th/nvim-cmp",
  -- commit = "799392a", -- ISSUE: https://github.com/hrsh7th/nvim-cmp/issues/1594
  event = { "InsertEnter", "CmdlineEnter", "CmdwinEnter" },
  dependencies = dependencies,
  config = config,
}
