-- stylua: ignore
local open_keymaps = {
  { ":",              "builtin",                   "All telescope pickers",    },
  { ".",              "resume",                    "Resume telescope",         },

  -- files
  { "f",              "find_files",                "Find files",               },
  { "F",              "git_files",                 "Git files",                },

  -- lsp
  { "?",              "diagnostics bufnr=0",       "Document diagnostics",     },
  { "!",              "diagnostics",               "Workspace diagnostics",    },

  -- symbols
  { "<M-7>",          "treesitter",                "Treesitter symbols",       k = "l", },
  { "<M-8>",          "lsp_document_symbols",      "LSP document symbols",     k = "l", },
  { "<M-9>",          "lsp_workspace_symbols",     "LSP workspace symbols",    k = "l", },

  -- vim
  { "<Space>r",       "oldfiles",                  "[Telescope] Recent files", k = "l", },
  { "b",              "buffers",                   "Buffers",                  },
  { "<C-S-o>",        "buffers",                   "[Telescope] Buffers",      k = "l", },
  { "o",              "vim_options",               "Vim options",              },
  { "H",              "highlights",                "Highlight groups",         },

  { "k",              "keymaps",                   "Keymaps",                  },

  { "C",              "command_history",           "Command history",          },
  { "<C-S-;>",        "command_history",           "Command history",          k = "l", },
  { "c",              "commands",                  "Commands",                 },
  { "<M-;>",          "commands",                  "Commands",                 k = "l", },

  { "<M-h>",          "help_tags",                 "[Telescope] Vim help",     k = "l", },

  { "<M-/>",          "current_buffer_fuzzy_find", "Search in buffer",         k = "l", },

  -- grep
  { "<Space>s",       "live_grep",                 "[Telescope] Live grep",    k = "l", },
  { "w",              "grep_string",               "Grep <word> under cursor", },

  -- git
  { "gc",             "git_commits",               "Git commits",              },
  { "gb",             "git_bcommits",              "Git buffer history",       },
  { "gB",             "git_branches",              "Git branches",             },
  { "gs",             "git_status",                "Git status",               },
  { "gS",             "git_stash",                 "Git stash",                },

  -- search
  { "M",              "man_pages",                 "Man pages",                },
  { "m",              "marks",                     "Jump to mark",             },

  -- notify
  { "n",              "notify",                    "Notifications",            },
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

  local insert = {
    -- no normal mode
    ["<Esc>"] = a.close,

    -- clear prompt input
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
    ["<C-x>"] = require("trouble.providers.telescope").open_with_trouble,

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
