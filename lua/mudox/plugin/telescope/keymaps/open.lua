-- stylua: ignore
local M = {
  { ":",         "builtin",                   "pickers",                   },
  { ".",         "resume",                    "resume",                    },

  -- files
  { "f",         "git_files",                 "git files",                 },
  { "F",         "find_files",                "find files",                },
  { "r",         "oldfiles",                  "old files",                 },

  -- lsp
  { "?",         "diagnostics bufnr=0",       "document diagnostics",      },
  { "!",         "diagnostics",               "workspace diagnostics",     },

  -- symbols
  { "gos ✓",     "lsp_document_symbols",      "lsp document symbols",      },
  { "got ✓",     "treesitter",                "treesitter symbols",        },
  { "goS ✓",     "lsp_workspace_symbols",     "lsp workspace symbols",     },

  -- vim
  { "a",         "autocommands",              "autocommands",              },
  { "b",         "buffers",                   "buffers",                   },
  { "<C-S-o> ✓", "buffers",                   "buffers",                   },
  { "o",         "vim_options",               "vim options",               },
  { "h",         "highlights",                "highlight groups",          },

  { "k",         "keymaps",                   "keymaps",                   },

  { "C",         "command_history",           "command history",           },
  { "c",         "commands",                  "commands",                  },

  { "<C-S-/> ✓", "help_tags",                 "vim help",                  },
  { K.sc"z ✓",   "help_tags",                 "vim help",                  },

  { "<M-/> ✓",   "current_buffer_fuzzy_find", "search in buffer",          },

  -- grep
  { "/",         "live_grep",                 "live grep",                 },
  { K.sc"g ✓",   "live_grep",                 "[telescope] live grep",     },
  { "w",         "grep_string",               "grep <cword> under cursor", },

  -- git
  { "gc",        "git_commits",               "git commits",               },
  { "gb",        "git_bcommits",              "git buffer history",        },
  { "gB",        "git_branches",              "git branches",              },
  { "gs",        "git_status",                "git status",                },
  { "gS",        "git_stash",                 "git stash",                 },

  -- search
  { "M",         "man_pages",                 "man pages",                 },
  { "m",         "marks",                     "jump to mark",              },

  -- notify
  { "n",         "notify",                    "notifications",             },
}

M = K.lazy_keys(M, {
  key_prefix = K.p("t"),
  main_cmd = "Telescope",
})

return M
