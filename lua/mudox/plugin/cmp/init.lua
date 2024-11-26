-- References:
--   https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/after/plugin/completion.lua

local dependencies = {
  -- buffer
  -- "hrsh7th/cmp-buffer",
  { "iguanacucumber/mag-buffer", name = "cmp-buffer" },

  -- cmdline
  -- "hrsh7th/cmp-cmdline",
  { "iguanacucumber/mag-cmdline", name = "cmp-cmdline" },
  "dmitmel/cmp-cmdline-history",

  -- path
  -- "hrsh7th/cmp-path",
  "https://codeberg.org/FelipeLema/cmp-async-path",

  -- snippet
  "saadparwaiz1/cmp_luasnip",

  -- lsp
  -- "hrsh7th/cmp-nvim-lsp",
  { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp" },
  "hrsh7th/cmp-nvim-lsp-signature-help",

  -- treesitter
  "ray-x/cmp-treesitter",

  -- rg
  "lukas-reineke/cmp-rg",

  -- language
  "octaltree/cmp-look",
  -- "hrsh7th/cmp-nvim-lua",
  { "iguanacucumber/mag-nvim-lua", name = "cmp-nvim-lua" },
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
      ghost_text = false,
      -- ghost_text = {
      --   hl_group = "LspCodeLens",
      -- },
    },
  }

  cmp.setup(opts)
  r("appearance").hightlight()

  cmp.setup.cmdline(":", {
    sources = r("sources").cmdline,
  })
end

return {
  -- not actively maintained
  -- "hrsh7th/nvim-cmp",

  -- active folk based on yioneko/nvim-cmp:perf
  -- https://www.reddit.com/r/neovim/comments/1fwy06w/magazinenvim_a_beta_nvimcmp_to_fix_bugs_implement/
  "iguanacucumber/magazine.nvim",
  name = "nvim-cmp",

  event = { "InsertEnter", "CmdlineEnter", "CmdwinEnter" },
  keys = { { "<leader>vc", "<Cmd>CmpStatus<Cr>", desc = "Cmp" } },
  dependencies = dependencies,
  config = config,
}
