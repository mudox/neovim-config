-- vim: fdm=marker fmr=\ 〈,\ 〉

local function s(name)
  return require("mudox.plugin.telescope." .. name)
end

-- Dependencies 〈

local smart_open = {
  "danielfalk/smart-open.nvim",
  branch = "0.2.x",
  dependencies = {
    "kkharji/sqlite.lua",
  },
}

local dependencies = {
  smart_open,

  -- plugins list
  "tsakirist/telescope-lazy.nvim",

  -- native sorter for performance
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- advanced `find_files` with `rg` arguments
  "nvim-telescope/telescope-live-grep-args.nvim",

  -- symbols data library
  "nvim-telescope/telescope-symbols.nvim",

  -- luasnip snippets list
  "benfowler/telescope-luasnip.nvim",

  -- headings
  "crispgm/telescope-heading.nvim",
}

-- Dependencies 〉

-- Default Settings 〈

local defaults = {
  -- icons
  selection_caret = " ",
  prompt_prefix = " ",
  multi_icon = "│",

  dynamic_preview_title = true,

  -- layout
  sorting_strategy = "ascending",
  layout_strategy = "flex",
  layout_config = {
    prompt_position = "top",
  },

  -- files finder
  vimgrep_arguments = {
    "rg",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
    "--trim", -- trim indentations
  },

  mappings = s("keymaps").mappings,
}

-- Default Settings 〉

-- Picker Settings 〈

local pickers = {
  buffers = {
    theme = "dropdown",
    previewer = false,
  },

  symbols = {
    theme = "dropdown",
  },

  builtin = {
    include_extensions = true,
    preview = { hide_on_startup = true },
  },

  treesitter = {
    symbols = {
      "Module",
      "Interface",
      "Trait",
      "Class",
      "Struct",
      "Function",
      "Method",
      "Constructor",
      "Field",
      "Property",
      "Variable",
      "Constant",
    },
    theme = "dropdown",
  },
  lsp_document_symbols = {
    symbols = {
      "Module",
      "Interface",
      "Trait",
      "Class",
      "Struct",
      "Function",
      "Method",
      "Constructor",
      "Field",
      "Property",
      "Variable",
      "Constant",
    },
    theme = "dropdown",
  },
  lsp_workspace_symbols = {
    symbols = {
      "Module",
      "Interface",
      "Trait",
      "Class",
      "Struct",
      "Function",
      "Method",
      "Constructor",
      "Field",
      "Property",
      -- "Variable",
      -- "Constant",
    },
    theme = "dropdown",
  },
}

-- Picker Settings 〉

-- Extension Settings 〈

local extensions = {
  smart_open = {
    show_scores = true,
    ignore_patterns = { "*.git/*", "*/tmp/*" },
    match_algorithm = "fzf",
    disable_devicons = false,
  },
  heading = {
    treesitter = true,
  }
}

-- Extension Settings 〉

-- Opts & Config 〈

local opts = {
  defaults = defaults,
  pickers = pickers,
  extensions = extensions,
}

local function config(_, o)
  local telescope = require("telescope")

  telescope.setup(o)

  local names = {
    "fzf",
    "lazy",
    "live_grep_args",
    "luasnip",
    "notify",
    "smart_open",
    "heading",
  }
  for _, name in ipairs(names) do
    telescope.load_extension(name)
  end
end

-- Opts & Config 〉

return {
  "nvim-telescope/telescope.nvim",
  dependencies = dependencies,
  cmd = "Telescope",
  keys = s("keymaps").keys,
  opts = opts,
  config = config,
}
