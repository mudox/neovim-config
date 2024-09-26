-- stylua: ignore start

-- helpers
local function r(mod) return require("mudox.plugin.which-key." .. mod) end
local function c(cmd) return "<Cmd>" .. cmd .. "<Cr>" end

local close = {
  { "<Bs>", group = "close" },

  { "<Bs>v",     c"confirm qall", desc = "[Neovim] Quit all"          },
  { "<Bs>V",     c"qall!",        desc = "[Neovim] Quit all forcibly" },

  { "<Bs><Tab>", c"tabclose",     desc = "[Neovim] Close tabpage"     },
  { "<Bs>w",     c"wincmd c",     desc = "[Neovim] Close window"      },
}

local edit = {
  { "<leader>e", group = "edit" },

  { "<leader>eq", c"EditQuery", desc = "[Neovim] Edit query",  },
  { "<leader>ee", c"edit!",     desc = "[Neovim] Reload file", },

  { "<leader>ed", group = "debug print" },
}

local refactoring = {
  { "<Bslash>", group = "refactoring" },

  { "<Bslash><Space>",  c"%s+\\n\\(\\s*\\n\\)\\{2,}+\\r\\r+e", desc = "Squeeze empty lines" },
}

local tabpage = {
  { "<Tab>", group = "tabpage" },

  { "<Tab>n",     c"tabnew",                 desc = "[Neovim] New tabpage"           },
  { "<Tab>c",     c"tabclose",               desc = "[Neovim] Close tabpage"         },
  { "<Tab>l",     "g<Tab>",                  desc = "[Neovim] Last accessed tabpage" },

  { "<Tab>o",     c"tabnext 1<Bar>tabonly",  desc = "[Neovim] Main tabpage only"     },
  { "<Tab><Tab>", c"tabnext 1",              desc = "[Neovim] Goto main tabpage"     },

  { "<Tab>.",     X.tabman.recreate_current, desc = "[Tabman] Recreate current"      },
}

K.nnop(",")
local plugin = {
  { "<leader>", group = "plugin" },

  { "<leader>b", group = "buffer"         },
  { "<leader>c", group = "test"           },
  { "<leader>d", group = "debug"          },
  edit,
  { "<leader>f", group = "files"          },
  { "<leader>g", group = "git"            },
  { "<leader>k", group = "kulala"         },
  { "<leader>p", group = "profile"        },
  { "<leader>r", group = "run"            },
  { "<leader>t", group = "telescope"      },
  { "<leader>v", group = "plugin views"   },
  { "<leader>w", group = "window"         },
  { "<leader>x", group = "trouble"        },
}

K.nnop(";")
local nvim = {
  { ";", group = "nvim" },

  unpack(r("lab")),
}

local common = {
  { "<Space>", group = "common" }
}

-- stylua: ignore end

return {
  plugin,
  nvim,
  common,
  refactoring,
  close,
  tabpage,

  r("view"),
  r("toggle"),
  r("next_prev"),
  r("insert"),

  { "<C-\\>", group = "toggleterm" },

  -- some keymaps (e.g. <C-w>c) do not work
  -- { ";w", proxy = "<C-w>", group = "window" },
}
