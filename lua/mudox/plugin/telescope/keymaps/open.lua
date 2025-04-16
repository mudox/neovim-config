-- stylua: ignore
local M = {
  { ":",          "builtin",                   "All telescope pickers",     },
  { ".",          "resume",                    "Resume telescope",          },

  -- files
  { "f",          "find_files",                "Find files",                },
  { "F",          "git_files",                 "Git files",                 },

  -- lsp
  { "?",          "diagnostics bufnr=0",       "Document diagnostics",      },
  { "!",          "diagnostics",               "Workspace diagnostics",     },

  -- symbols
  { "<C-1> ✓",    "lsp_document_symbols",      "LSP document symbols",      },
  { "<C-2> ✓",    "treesitter",                "Treesitter symbols",        },
  { "<C-3> ✓",    "lsp_workspace_symbols",     "LSP workspace symbols",     },

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

  { "<C-S-/> ✓",  "help_tags",                 "[Telescope] Vim help",      },

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

M = K.lazy_keys(M, {
  key_prefix = "<leader>t",
  main_cmd = "Telescope",
})

return M
