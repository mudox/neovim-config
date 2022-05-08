-- vim: fdm=marker fmr=〈,〉

-- highlight 〈

local highlight = {
  -- `false` will disable the whole extension
  enable = true,

  -- list of language that will be disabled
  disable = { "html", "css", "lua" },

  -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
  -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
  -- Using this option may slow down your editor, and you may see some duplicate highlights.
  -- Instead of true it can also be a list of languages
  additional_vim_regex_highlighting = false,
}

-- 〉

-- textobjects 〈

local textobjects = {
  select = {
    enable = true,

    -- Automatically jump forward to textobj, similar to targets.vim
    lookahead = true,

    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
    },
  },

  swap = {
    enable = true,
    swap_next = {
      ["\\sf"] = "@parameter.inner",
    },
    swap_previous = {
      ["\\sb"] = "@parameter.inner",
    },
  },

  move = {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
    goto_next_start = {
      ["]m"] = "@function.outer",
      ["]]"] = "@class.outer",
    },
    goto_next_end = {
      ["]M"] = "@function.outer",
      ["]["] = "@class.outer",
    },
    goto_previous_start = {
      ["[m"] = "@function.outer",
      ["[["] = "@class.outer",
    },
    goto_previous_end = {
      ["[M"] = "@function.outer",
      ["[]"] = "@class.outer",
    },
  },

  lsp_interop = {
    enable = true,
    border = "none",
    peek_definition_code = {
      ["gy"] = "@function.outer",
      ["gY"] = "@class.outer",
    },
  },
}

-- 〉

-- rainbow 〈

local rainbow = {
  enable = true,
  -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
  extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
  max_file_lines = nil, -- Do not enable for files with more than n lines, int
  -- colors = {}, -- table of hex strings
  -- termcolors = {} -- table of colour name strings
}

-- 〉

-- Neog subparsers 〈
-- NOTE: must be put before `require('nvim-treesitter.configs').setup()`

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.norg_meta = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
    files = { "src/parser.c" },
    branch = "main",
  },
}

parser_configs.norg_table = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
    files = { "src/parser.c" },
    branch = "main",
  },
}

-- 〉

-- Setup 〈

local opts = {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    "vim",

    "lua",
    "fennel",

    "bash",

    "dockerfile",

    "c",
    "cpp",
    "make",

    "python",
    "rust",

    "javascript",
    "typescript",
    "vue",
    "tsx",

    "http",

    "html",
    "css",
    "scss",

    "json",
    "json5",
    "jsonc",
    "toml",
    "yaml",

    "go",
    "java",

    "swift",
    "kotlin",

    "norg",
    "norg_meta",
    "norg_table",

    "markdown",

    "query",

    "rust",

    -- "scheme",
    -- "scala",
    -- "haskell",
  },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = {
    "kotlin",
    "d",
    "php",
    "phpdoc",
    "swift",
  },

  -- Modules

  highlight = highlight,

  textobjects = textobjects,

  rainbow = rainbow,
}

require("nvim-treesitter.configs").setup(opts)

-- 〉
