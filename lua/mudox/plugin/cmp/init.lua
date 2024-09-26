-- References:
--   https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/after/plugin/completion.lua

local dependencies = {
  -- basics
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-cmdline",
  "dmitmel/cmp-cmdline-history",
  "hrsh7th/cmp-path",

  -- snippet
  "saadparwaiz1/cmp_luasnip",

  -- lsp
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lsp-signature-help",

  -- treesitter
  "ray-x/cmp-treesitter",

  -- rg
  "lukas-reineke/cmp-rg",

  -- language
  "octaltree/cmp-look",
  "hrsh7th/cmp-nvim-lua",
  "buschco/nvim-cmp-ts-tag-close",

  -- icons
  "onsails/lspkind.nvim",

  -- ai
  -- { "tzachar/cmp-tabnine", build = "./install.sh" }, -- resources hungry
}

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

    sources = r("sources").common,
    sorting = r("sources").sorting,

    mapping = r("keymaps").base,

    formatting = r("appearance").formatting,
    view = r("appearance").view,
    window = r("appearance").window,

    experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
    },
  }

  cmp.setup(opts)

  cmp.setup.cmdline(":", {
    sources = r("sources").cmdline,
  })
end

return {
  -- "hrsh7th/nvim-cmp",

  -- HACK: for performance gain
  "yioneko/nvim-cmp",
  branch = "perf",

  event = { "InsertEnter", "CmdlineEnter", "CmdwinEnter" },
  keys = { { "<leader>vc", "<Cmd>CmpStatus<Cr>", desc = "Cmp" } },
  dependencies = dependencies,
  config = config,
}
