-- vim: fdm=marker fmr=\ 〈,\ 〉

local function s(name)
  return require("mudox.plugin.telescope." .. name)
end

-- Dependencies 〈

local dependencies = {
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

  mappings = s("keymap").mappings,
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

local extensions = {}

-- Extension Settings 〉

-- Opts & Config 〈

local opts = {
  defaults = defaults,
  pickers = pickers,
  extensions = extensions,

  update_events = { "TextChanged", "TextChangedI" },
  region_check_events = "InsertEnter",
  delete_check_events = { "TextChanged", "InsertLeave" },

  store_selection_keys = "<C-f>",
}

local function config(_, options)
  local telescope = require("telescope")

  telescope.setup(options)

  local names = {
    "lazy",
    "fzf",
    "live_grep_args",
    "notify",
    "luasnip",
  }
  for _, name in ipairs(names) do
    telescope.load_extension(name)
  end

  -- HACK: for bug: https://github.com/nvim-telescope/telescope.nvim/issues/2027#issuecomment-1510001730
  vim.api.nvim_create_autocmd("WinLeave", {
    callback = function()
      if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
      end
    end,
  })
end

-- Opts & Config 〉

return {
  "nvim-telescope/telescope.nvim",
  dependencies = dependencies,
  cmd = "Telescope",
  keys = s("keymap").keys,
  opts = opts,
  config = config,
}
