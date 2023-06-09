-- vim: fdm=marker fmr=〈,〉

-- Keys 〈

local function open(picker, opts)
  opts = vim.deepcopy(opts or {})

  return function()
    local dir = require("mudox.util.path").get_root_dir()
    if not dir then
      dir = vim.loop.cwd()
    end
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
  { ":",                "builtin",                   "All Telescope Pickers"    },
  { "<leader>t<Space>", "resume",                    "Resume Telescope"         },

  -- lsp
  { "?",                "diagnostics bufnr=0",       "Document Diagnostics"     },
  { "!",                "diagnostics",               "Workspace Diagnostics"    },
  { ".",                "lsp_code_actions",          "Code Actions"             },

  -- symbols
  { "<M-7>",            "treesitter",                "TreeSitter Symbols"       },
  { "<M-9>",            "lsp_workspace_symbols",     "LSP Workspace Symbols"    },
  { "<M-8>",            "lsp_document_symbols",      "LSP Document Symbols"     },

  -- vim
  { "<Space>r",         "oldfiles",                  "Recent Files"             },
  { "<C-S-n>",          "buffers",                   "Switch Buffer"            },
  { "o",                "vim_options",               "Vim Options"              },
  { "H",                "highlights",                "Highlight Groups"         },
  { "k",                "keymaps",                   "Keymaps"                  },
  { "c",                "command_history",           "Command History"          },
  { "C",                "commands",                  "Commands"                 },

  { "h",                "help_tags",                 "Vim Help"                 },
  { "<Space>h",         "help_tags",                 "Vim Help"                 },

  { "/",                "current_buffer_fuzzy_find", "Search in Buffer"         },
  { "<M-/>",            "current_buffer_fuzzy_find", "Search in Buffer"         },

  -- grep
  { "<Space>s",         open("live_grep"),           "Live Grep"                },
  { "w",                open("grep_string"),         "Grep <Word> Under Cursor" },

  -- files
  { "<C-p>",            open("files"),               "Find Files"               },

  -- plugins
  { "p",                "lazy",                      "Lazy Plugins"             },

  -- git
  { "gc",               "git_commits",               "Git Commits"              },
  { "gb",               "git_bcommits",              "Git Buffer History"       },
  { "gB",               "git_branches",              "Git Branches"             },
  { "gs",               "git_status",                "Git Status"               },
  { "gS",               "git_stash",                 "Git Stash"                },

  -- search
  { "M",                "man_pages",                 "Man Pages"                },
  { "m",                "marks",                     "Jump to Mark"             },

  -- notify
  { "n",                "notify",                    "Notifications"            },

  -- misc
  { "i",                font_symbols,                "Font Symbols"             },

  -- luasnip snippets list
  { "s",                "luasnip theme=dropdown",    "Font Symbols"             },
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

-- keys 〉

-- Mappings 〈

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

    -- <Cr> for edit in current window
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

-- Mappings 〉

return {
  keys = keys,
  mappings = mappings,
}
