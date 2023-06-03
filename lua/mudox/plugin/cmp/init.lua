-- vim: fdm=marker fmr=〈,〉

local function config()
  local cmp = require("cmp")

  local function r(name)
    return require("mudox.plugin.cmp." .. name)
  end

  local opts = {
    completion = {
      completeopt = "menu,menuone,noinsert,noselect",
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = r("keymaps")(),
    sources = r("sources").common,
    view = {
      entries = { name = "custom", selection_order = "near_cursor" }, -- can be "custom", "wildmenu" or "native" (experimental)
    },
    formatting = r("appearance").formatting,
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
    sources = r("sources").search,
  })

  -- Use cmdline & path sources for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = r("sources").cmdline,
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
  event = { "InsertEnter", "CmdlineEnter", "CmdwinEnter" },
  dependencies = dependencies,
  config = config,
}
