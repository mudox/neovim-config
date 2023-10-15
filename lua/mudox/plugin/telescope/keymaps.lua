-- vim: fdm=marker fmr=〈,〉

-- Keymaps to invoke telescope 〈

local function font_symbols()
  local s = require("telescope.builtin").symbols
  if vim.v.count ~= 0 then
    s() -- list all symbols
  else
    s { sources = { "nerd", "math" } }
  end
end

local kb = require("mudox.keyboard")

-- stylua: ignore start
local keymaps = {
  { ":",                            "builtin",                   "All telescope pickers"    },
  { ".",                            "resume",                    "Resume telescope"         },

  -- lsp
  { "?",                            "diagnostics bufnr=0",       "Document diagnostics"     },
  { "!",                            "diagnostics",               "Workspace diagnostics"    },

  -- symbols
  { "<M-7>",                        "treesitter",                "Treesitter symbols"       },
  { "<M-8>",                        "lsp_document_symbols",      "LSP document symbols"     },
  { "<M-9>",                        "lsp_workspace_symbols",     "LSP workspace symbols"    },

  -- vim
  { "<Space>r",                     "oldfiles",                  "Recent files"             },
  { "b",                            "buffers",                   "Switch buffer"            },
  { '-' .. kb.cs.o,                 "buffers",                   "Switch buffer"            },
  { "o",                            "vim_options",               "Vim options"              },
  { "H",                            "highlights",                "Highlight groups"         },

  { "k",                            "keymaps",                   "Keymaps"                  },

  { "C",                            "command_history",           "Command history"          },
  { "-" .. kb.cs[";"],              "command_history",           "Command history"          },
  { "c",                            "commands",                  "Commands"                 },
  { "<M-;>",                        "commands",                  "Commands"                 },

  { "h",                            "help_tags",                 "Vim help"                 },
  { "<Space>h",                     "help_tags",                 "Vim help"                 },

  { "/",                            "current_buffer_fuzzy_find", "Search in buffer"         },
  { "<M-/>",                        "current_buffer_fuzzy_find", "Search in buffer"         },

  -- grep
  { "<Space>s",                     "live_grep",                 "Live grep"                },
  { "w",                            "grep_string",               "Grep <word> under cursor" },
  { "G",                            "live_grep_args",            "Live grep args (rg raw)"  },

  -- files
  { "f",                            "find_files",                "Smart open"               },
  { "F",                            "git_files",                 "Smart open"               },
  { "<Space><Space>",               "smart_open",                "Smart open"               },
  { "<C-p>",                        "smart_open",                "Smart open"               },

  -- plugins
  { "p",                            "lazy",                      "Lazy plugins"             },

  -- git
  { "gc",                           "git_commits",               "Git commits"              },
  { "gb",                           "git_bcommits",              "Git buffer history"       },
  { "gB",                           "git_branches",              "Git branches"             },
  { "gs",                           "git_status",                "Git status"               },
  { "gS",                           "git_stash",                 "Git stash"                },

  -- search
  { "M",                            "man_pages",                 "Man pages"                },
  { "m",                            "marks",                     "Jump to mark"             },

  -- notify
  { "n",                            "notify",                    "Notifications"            },

  -- misc
  { "i",                            font_symbols,                "Font symbols"             },

  -- luasnip snippets list
  { "s",                            "luasnip theme=dropdown",    "Font symbols"             },

  -- heading
  { "O",                            "heading",                   "Heading"                  },
}
-- stylua: ignore end

keymaps = require("mudox.util.keymap").lazy_keys(keymaps, {
  key_prefix = "<leader>t",
  main_cmd = "Telescope",
})

-- Keymaps to invoke telescope 〉

-- Mappings 〈

local function a()
  return require("telescope.actions")
end

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

-- stylua: ignore
local picker_keymaps = {
  i = {
    -- no normal mode
    ["<Esc>"]       = function(...) return a().close(...) end,

    -- clear prompt input
    ["<C-u>"]       = false,

    -- preview
    ["?"]           = function(...) require("telescope.actions.layout").toggle_preview(...) end,

    -- scroll preview
    -- ["<C-d>"]    = false,
    ["<C-f>"]       = function(...) return a().preview_scrolling_down(...) end,
    ["<C-b>"]       = function(...) return a().preview_scrolling_up(...) end,

    -- <Cr> for edit in current window
    -- <C-s> for horizontal split open
    -- <C-v> for vertical split open
    -- <C-t> for tabpage open
    ["<C-s>"]       = function(...) a().select_horizontal(...) end,

    -- send to trouble
    ["<C-x>"]       = function(...) return require("trouble.providers.telescope").open_with_trouble(...) end,

    -- history
    ["<C-j>"]       = function(...) return a().cycle_history_next(...) end,
    ["<C-k>"]       = function(...) return a().cycle_history_prev(...) end,

    -- <C-/>
    [kb.c["/"]]     = function(...) return a().which_key(...) end,

    ["<C-d>"]       = flash,
  },

  n = {
    ["q"]           = function(...) return a().close(...) end,
  },
}

-- Mappings 〉

return {
  keys = keymaps,
  mappings = picker_keymaps,
}
