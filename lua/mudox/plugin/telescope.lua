local dependencies = {
  -- plugins list
  "tsakirist/telescope-lazy.nvim",

  -- native sorter for performance
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- advanced `find_files` with `rg` arguments
  "nvim-telescope/telescope-live-grep-args.nvim",

  -- symbols data library
  "nvim-telescope/telescope-symbols.nvim",
}

local function open(picker, opts)
  opts = vim.deepcopy(opts or {})

  return function()
    local dir = require("mudox.lib.path").get_root_dir()
    if not dir then
      dir = vim.loop.cwd()
    end
    print(("[Telescope %s] using root dir: %s"):format(picker, dir))
    opts = vim.tbl_deep_extend("force", { cwd = dir }, opts)

    if picker == "files" then
      local cmd = ("git -C '%s' rev-parse --is-inside-work-tree"):format(dir)
      local in_git_repo = vim.fn.systemlist(cmd)[1] == "true"
      if in_git_repo then
        opts.show_untracked = true
        picker = "git_files"
      else
        picker = "find_files"
      end
    end

    require("telescope.builtin")[picker](opts)
  end
end

local function font_symbols()
  local s = require("telescope.builtin").symbols
  if vim.v.count ~= 0 then
    s() -- list all symbols
  else
    s { sources = { "nerd", "math" } }
  end
end

-- stylua: ignore start
local keys = {
  { ":",        "builtin",                   "All Telescope Pickers"    },
  { "<Space>",  "resume",                    "Resume"                   },

  -- lsp
  { "?",        "diagnostics bufnr=0",       "Document Diagnostics"     },
  { "!",        "diagnostics",               "Workspace Diagnostics"    },
  { ".",        "lsp_code_actions",          "Code Actions"             },

  -- symbols
  { "<M-i>",    "treesitter",                "TreeSitter Symbols"       },
  { "<M-9>",    "lsp_workspace_symbols",     "LSP Workspace Symbols"    },
  { "<M-8>",    "lsp_document_symbols",      "LSP Document Symbols"     },

  -- vim
  { "<Space>r", "oldfiles",                  "Recent Files"             },
  { "<C-S-n>",  "buffers",                   "Switch Buffer"            },
  { "h",        "help_tags",                 "Vim Help"                 },
  { "o",        "vim_options",               "Vim Options"              },
  { "H",        "highlights",                "Highlight Groups"         },
  { "/",        "current_buffer_fuzzy_find", "Search in Buffer"         },
  { "k",        "keymaps",                   "Keymaps"                  },
  { "c",        "command_history",           "Command History"          },
  { "C",        "commands",                  "Commands"                 },

  -- grep
  { "<Space>s", open("live_grep"),           "Live Grep"                },
  { "w",        open("grep_string"),         "Grep <Word> Under Cursor" },

  -- files
  { "<C-p>",    open("files"),               "Find Files"               },

  -- plugins
  { "p",        "lazy",                      "Lazy"                     },

  -- git
  { "gc",       "git_commits",               "Git Commits"              },
  { "gb",       "git_bcommits",              "Git Buffer History"       },
  { "gB",       "git_branches",              "Git Branches"             },
  { "gs",       "git_status",                "Git Status"               },

  -- search
  { "M",        "man_pages",                 "Man Pages"                },
  { "m",        "marks",                     "Jump to Mark"             },

  -- notify
  { "n",        "notify",                    "Notifications"            },

  -- misc
  { "i",        font_symbols,                "Font Symbols"             },
}
-- stylua: ignore end

for _, v in pairs(keys) do
  if v[1]:sub(1, 1) ~= "<" then
    v[1] = "<leader>t" .. v[1]
  end

  if type(v[2]) == "string" then
    v[2] = "<Cmd>Telescope " .. v[2] .. "<Cr>"
  end

  v.desc = v[3]
  v[3] = nil
end

local mappings = {
  i = {
    -- no normal mode
    ["<Esc>"] = function(...)
      return require("telescope.actions").close(...)
    end,

    -- clear prompt input
    ["<C-u>"] = false,

    -- preview
    ["?"] = function(...)
      require("telescope.actions.layout").toggle_preview(...)
    end,

    -- scroll preview
    ["<C-d>"] = false,
    ["<C-f>"] = function(...)
      return require("telescope.actions").preview_scrolling_down(...)
    end,
    ["<C-b>"] = function(...)
      return require("telescope.actions").preview_scrolling_up(...)
    end,

    -- <C-s> for horizontal split open
    -- <C-v> for vertical split open
    -- <C-t> for tabpage open
    ["<C-s>"] = function(...)
      require("telescope.actions").select_horizontal(...)
    end,

    -- send to trouble
    ["<C-x>"] = function(...)
      return require("trouble.providers.telescope").open_with_trouble(...)
    end,

    -- history
    ["<C-j>"] = function(...)
      return require("telescope.actions").cycle_history_next(...)
    end,
    ["<C-k>"] = function(...)
      return require("telescope.actions").cycle_history_prev(...)
    end,
  },
  n = {
    ["q"] = function(...)
      return require("telescope.actions").close(...)
    end,
  },
}

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

  mappings = mappings,
}

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

local extensions = {}

local opts = {
  defaults = defaults,
  pickers = pickers,
  extensions = extensions,
}

local function config(_, options)
  local telescope = require("telescope")

  telescope.setup(options)

  local names = {
    "lazy",
    "fzf",
    "live_grep_args",
    "notify",
  }
  for _, name in ipairs(names) do
    telescope.load_extension(name)
  end
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = dependencies,
  cmd = "Telescope",
  keys = keys,
  opts = opts,
  config = config,
}
