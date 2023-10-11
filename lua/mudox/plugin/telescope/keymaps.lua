-- vim: fdm=marker fmr=〈,〉

-- Keymaps to invoke telescope 〈

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

local kb = require("mudox.keyboard")

-- stylua: ignore start
local keymaps = {
  { ":",                     "builtin",                   "All telescope pickers"    },
  { ".",                     "resume",                    "Resume telescope"         },

  -- lsp
  { "?",                     "diagnostics bufnr=0",       "Document diagnostics"     },
  { "!",                     "diagnostics",               "Workspace diagnostics"    },

  -- symbols
  { "<M-7>",                 "treesitter",                "Treesitter symbols"       },
  { "<M-8>",                 "lsp_document_symbols",      "LSP document symbols"     },
  { "<M-9>",                 "lsp_workspace_symbols",     "LSP workspace symbols"    },

  -- vim
  { "<Space>r",              "oldfiles",                  "Recent files"             },
  { "b",                     "buffers",                   "Switch buffer"            },
  { "o",                     "vim_options",               "Vim options"              },
  { "H",                     "highlights",                "Highlight groups"         },

  { "k",                     "keymaps",                   "Keymaps"                  },

  { "C",                     "command_history",           "Command history"          },
  { kb.ctrl_shift_semicolon, "command_history",           "Command history"          },
  { "c",                     "commands",                  "Commands"                 },
  { "<M-;>",                 "commands",                  "Commands"                 },

  { "h",                     "help_tags",                 "Vim help"                 },
  { "<Space>h",              "help_tags",                 "Vim help"                 },

  { "/",                     "current_buffer_fuzzy_find", "Search in buffer"         },
  { "<M-/>",                 "current_buffer_fuzzy_find", "Search in buffer"         },

  -- grep
  { "<Space>s",              open("live_grep"),           "Live grep"                },
  { "w",                     open("grep_string"),         "Grep <word> under cursor" },
  { "G",                     open("live_grep_args"),      "Live grep args (rg raw)"  },

  -- files
  { "<C-p>",                 open("files"),               "Find files"               },
  { "<Space><Space>",        "smart_open",                "Smart open"               },

  -- plugins
  { "p",                     "lazy",                      "Lazy plugins"             },

  -- git
  { "gc",                    "git_commits",               "Git commits"              },
  { "gb",                    "git_bcommits",              "Git buffer history"       },
  { "gB",                    "git_branches",              "Git branches"             },
  { "gs",                    "git_status",                "Git status"               },
  { "gS",                    "git_stash",                 "Git stash"                },

  -- search
  { "M",                     "man_pages",                 "Man pages"                },
  { "m",                     "marks",                     "Jump to mark"             },

  -- notify
  { "n",                     "notify",                    "Notifications"            },

  -- misc
  { "i",                     font_symbols,                "Font symbols"             },

  -- luasnip snippets list
  { "s",                     "luasnip theme=dropdown",    "Font symbols"             },

  -- heading
  { "O",                     "heading",                   "Heading"                  },
}
-- stylua: ignore end

for _, v in pairs(keymaps) do
  if v[1]:sub(1, 1) ~= "<" then
    v[1] = "<leader>t" .. v[1]
  end

  if type(v[2]) == "string" then
    v[2] = "<Cmd>Telescope " .. v[2] .. "<Cr>"
  end

  v.desc = v[3]
  v[3] = nil
end

-- Keymaps to invoke telescope 〉

-- Mappings 〈

local picker_keymaps = {
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

    -- <C-/>
    [""] = function(...)
      return require("telescope.actions").which_key(...)
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
  keys = keymaps,
  mappings = picker_keymaps,
}
