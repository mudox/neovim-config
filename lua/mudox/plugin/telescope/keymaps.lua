-- stylua: ignore
local open_keymaps = {
  { ":",          "builtin",                   "All telescope pickers",     },
  { ".",          "resume",                    "Resume telescope",          },

  -- files
  { "f",          "find_files",                "Find files",                },
  { "F",          "git_files",                 "Git files",                 },

  -- lsp
  { "?",          "diagnostics bufnr=0",       "Document diagnostics",      },
  { "!",          "diagnostics",               "Workspace diagnostics",     },

  -- symbols
  { "<M-7> ✓",    "treesitter",                "Treesitter symbols",        },
  { "<M-8> ✓",    "lsp_document_symbols",      "LSP document symbols",      },
  { "<M-9> ✓",    "lsp_workspace_symbols",     "LSP workspace symbols",     },

  -- vim
  { "<Space>r ✓", "oldfiles",                  "[Telescope] Recent files",  },
  { "a",          "autocommands",              "autocommands",              },
  { "b",          "buffers",                   "Buffers",                   },
  { "<C-S-o> ✓",  "buffers",                   "[Telescope] Buffers",       },
  { "o",          "vim_options",               "Vim options",               },
  { "h",          "highlights",                "Highlight groups",          },

  { "k",          "keymaps",                   "Keymaps",                   },

  { "C",          "command_history",           "Command history",           },
  { "<C-S-;> ✓",  "command_history",           "Command history",           },
  { "c",          "commands",                  "Commands",                  },
  { "<M-;> ✓",    "commands",                  "Commands",                  },

  { "<M-h> ✓",    "help_tags",                 "[Telescope] Vim help",      },

  { "<M-/> ✓",    "current_buffer_fuzzy_find", "Search in buffer",          },

  -- grep
  { "<Space>s ✓", "live_grep",                 "[Telescope] Live grep",     },
  { "w",          "grep_string",               "Grep <cword> under cursor", },

  -- git
  { "gc",         "git_commits",               "Git commits",               },
  { "gb",         "git_bcommits",              "Git buffer history",        },
  { "gB",         "git_branches",              "Git branches",              },
  { "gs",         "git_status",                "Git status",                },
  { "gS",         "git_stash",                 "Git stash",                 },

  -- search
  { "M",          "man_pages",                 "Man pages",                 },
  { "m",          "marks",                     "Jump to mark",              },

  -- notify
  { "n",          "notify",                    "Notifications",             },
}

open_keymaps = K.lazy_keys(open_keymaps, {
  key_prefix = "<leader>t",
  main_cmd = "Telescope",
})

local function flash(prompt_bufnr)
  require("flash").jump {
    pattern = "^",
    label = { before = false, after = true, rainbow = { enabled = true } },
    highlight = { matches = false },
    search = {
      mode = "search",
      exclude = {
        function(win)
          return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
        end,
      },
    },
    action = function(match)
      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
      picker:set_selection(match.pos[1] - 1)
    end,
  }
end

local function picker_keymaps()
  local a = require("telescope.actions")

  local function open_with_trouble(...)
    require("trouble.sources.telescope").open(...)
  end

  local function add_to_trouble(...)
    require("trouble.sources.telescope").add(...)
  end

  local insert = {
    -- disable normal mode
    ["<Esc>"] = a.close,

    -- restore nvim default
    ["<C-u>"] = false,

    -- preview
    ["?"] = require("telescope.actions.layout").toggle_preview,

    -- scroll preview
    ["<C-f>"] = a.preview_scrolling_down,
    ["<C-b>"] = a.preview_scrolling_up,

    -- scroll results
    ["<Down>"] = a.results_scrolling_down,
    ["<Up>"] = a.results_scrolling_up,

    -- <Cr> for edit in current window
    -- <C-s> for horizontal split open
    -- <C-v> for vertical split open
    -- <C-t> for tabpage open
    ["<C-s>"] = a.select_horizontal,

    -- send to trouble
    -- ISSUE: error: filename is required
    ["<C-x>"] = open_with_trouble,
    ["<C-a>"] = add_to_trouble,

    -- history
    ["<C-j>"] = a.cycle_history_next,
    ["<C-k>"] = a.cycle_history_prev,

    ["<C-/>"] = a.which_key,

    ["<C-d>"] = flash,
  }

  local normal = {
    ["q"] = function(...)
      return a().close(...)
    end,
  }

  return { i = insert, n = normal }
end

return {
  open = open_keymaps,
  picker = picker_keymaps,
}
