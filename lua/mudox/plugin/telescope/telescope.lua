local function r(name)
  return require("mudox.plugin.telescope." .. name)
end

-- common settings shared by all pickers
local function defaults()
  return {
    -- icons
    -- stylua: ignore start
    selection_caret = " ",
    prompt_prefix   = " ",
    multi_icon      = "│",
    -- stylua: ignore end

    -- dynamic_preview_title = true,

    -- layout
    layout_strategy = "flex",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",

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

    mappings = r("keymaps").picker(),

    -- avoid opening files in edgy panes
    get_selection_window = function()
      require("edgy").goto_main()
      return 0
    end,
  }
end

-- default settings for each builtin picker
local function pickers()
  return {
    buffers = {
      theme = "dropdown",
      previewer = false,
    },

    command_history = {
      theme = "dropdown",
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
        "Variable",
        "Constant",
      },
      theme = "dropdown",
    },
  }
end

local function config()
  r("patch")

  local t = require("telescope")

  t.setup {
    defaults = defaults(),
    pickers = pickers(),
  }

  t.load_extension("fzf")
  t.load_extension("notify")
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  cmd = "Telescope",
  keys = r("keymaps").open,
  config = config,
}
