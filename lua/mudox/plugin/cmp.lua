local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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

-- see: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
local function sources()
  return {
    -- LSP & TreeSitter
    { name = "nvim_lsp", max_item_count = 20 },
    { name = "treesitter" },

    -- lua
    { name = "nvim_lua", max_item_count = 10 },
    { name = "nvim_lsp_signature_help" },

    -- tokens from opened buffers
    { name = "buffer" },

    -- file system paths
    { name = "path" },

    -- LuaSnip snippets
    { name = "luasnip" },

    -- npm
    { name = "npm", keyword_length = 3 },

    -- TabNine AI completion engine
    { name = "cmp_tabnine", max_item_count = 10 },

    -- source from `rg`
    { name = "rg", max_item_count = 10 },

    -- words
    {
      name = "look",
      keyword_length = 3,
      option = {
        convert_case = true,
        loud = true,
        dict = "/usr/share/dict/words",
      },
    },
  }
end

-- see: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance
local function formatting()
  -- TODO: fancy menu appearance
  return {
    format = function(_, item)
      local icons = require("mudox.ui").icons.kind
      if icons[item.kind] then
        item.kind = icons[item.kind] .. " " .. item.kind
      end
      return item
    end,
  }
end

local function config()
  local cmp = require("cmp")

  local opts = {
    completion = {
      completeopt = "menu,menuone,noinsert",
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
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),

    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })
end

local dependencies = {
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-cmdline",
  "dmitmel/cmp-cmdline-history",
  "hrsh7th/cmp-path",

  "saadparwaiz1/cmp_luasnip",

  "hrsh7th/cmp-nvim-lsp",
  "ray-x/cmp-treesitter",
  { "tzachar/cmp-tabnine", build = "./install.sh" },

  "lukas-reineke/cmp-rg",

  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-nvim-lsp-signature-help",

  "octaltree/cmp-look",
}

return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdWinEnter" },
  dependencies = dependencies,
  config = config,
}
