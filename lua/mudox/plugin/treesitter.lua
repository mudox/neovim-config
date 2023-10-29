local keys = {
  { "<C-Space>", desc = "Begin / expand selection", mode = { "n", "x" } },
  { "<Bs>", desc = "Shrink selection", mode = "x" },
}

local opts = {}

opts.ensure_installed = {
  "bash",
  "c",
  "html",
  "http",
  "javascript",
  "json",
  "lua",
  "luap",
  "markdown",
  "markdown_inline",
  "python",
  "query", -- TreeSitter query language
  "regex",
  "tsx",
  "typescript",
  "vim",
  "yaml",
}

opts.highlight = {
  enable = true,
}

opts.indent = {
  enable = true,
}

opts.context_commentstring = {
  enable = true,
  enable_autocmd = false,
}

opts.incremental_selection = {
  enable = true,
  keymaps = {
    init_selection = "<C-Space>",
    node_incremental = "<C-Space>",
    scope_incremental = "<Nop>",
    node_decremental = "<Bs>",
  },
}

opts.query_linter = {
  enable = true,
  use_virtual_text = true,
  lint_events = { "BufWrite", "CursorHold" },
}

local function config()
  require("nvim-treesitter.configs").setup(opts)

  -- disable injection queries for better performance
  -- vim.treesitter.query.set("lua", "injections", "")
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter-textobjects",
      -- rarely used currently
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    keys = keys,
    init = function()
      vim.o.foldmethod = "expr"
      vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.o.foldtext = "v:lua.require('mudox.ui.fold').foldtext()"
      -- vim.o.foldminlines = 6
      vim.o.foldnestmax = 3
    end,
    config = config,
  },
}
