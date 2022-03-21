-- vim: fdm=marker fmr=〈,〉

-- Syntax highlighting 〈
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.norg_meta = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
    files = { "src/parser.c" },
    branch = "main",
  },
}

parser_configs.norg_table = {
  install_info = {
    url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
    files = { "src/parser.c" },
    branch = "main",
  },
}

-- 〉

-- Icons 〈

local function level_icons(icon)
  local t = {}
  for i = 1, 6 do
    t[("level_%d"):format(i)] = {
      icon = (" "):rep(i - 1) .. icon,
    }
  end
  return t
end

local concealer_icons = {
  link = level_icons("➠ "),
  -- list = level_icons("●"),
  list = level_icons("◆"),
  quote = level_icons("┃"),
  heading = {
    level_1 = {
      icon = " ",
    },
    level_2 = {
      icon = "  ",
    },
    level_3 = {
      icon = "   ",
    },
    level_4 = {
      icon = "    ",
    },
    level_5 = {
      icon = "     ",
    },
    level_6 = {
      icon = "      ",
    },
  },
  todo = {
    done = {
      icon = "✔",
    },
    undone = {
      icon = " ",
    },
    pending = {
      icon = "",
    },
    uncertain = {
      icon = "",
    },
    on_hold = {
      icon = "",
    },
    cancelled = {
      icon = "",
    },
    recurring = {
      icon = "",
    },
    important = {
      icon = "",
    },
    urgent = {
      icon = "",
    },
  },
  marker = {
    icon = "",
  },
  footnote = {
    single = {
      icon = "❛",
    },
    multi_prefix = {
      icon = "❝ ",
    },
    multi_suffix = {
      icon = "❞ ",
    },
  },
  definition = {
    single = {
      icon = " ",
    },
    multi_prefix = {
      icon = " ",
    },
    multi_suffix = {
      icon = "❞ ",
    },
  },
}

-- 〉

-- Dirman 〈

local dirman = {
  workspaces = {
    work = "~/OneDrive/Neorg/work",
    home = "~/OneDrive/Neorg/home",
  },
  default_workspace = "home",
  autodir = true,
  index = "index.norg",
}

-- 〉

-- Keybindings 〈

local keybindings = function(k)
  k.remap_key("norg", "n", "<C-s>", "<M-i>")

  -- <C-Space> to check todo item
  k.remap_event("norg", "n", "<C-Space>", "core.norg.qol.todo_items.todo.task_done")

  k.map("norg", "n", ",oc", "<Cmd>Neorg keybind norg core.gtd.base.capture<Cr>")
  k.map("norg", "n", ",ov", "<Cmd>Neorg keybind norg core.gtd.base.views<Cr>")
  k.map("norg", "n", ",oe", "<Cmd>Neorg keybind norg core.gtd.base.edit<Cr>")
end

-- 〉

require("neorg").setup {
  load = {
    ["core.defaults"] = {},
    ["core.keybinds"] = {
      config = {
        nerog_leader = ",o",
        hook = keybindings,
      },
    },
    ["core.norg.manoeuvre"] = {},
    ["core.norg.dirman"] = {
      config = dirman,
    },
    ["core.norg.concealer"] = {
      config = {
        icons = concealer_icons,
      },
    },
    ["core.norg.qol.toc"] = {},
    ["core.norg.journal"] = {
      config = {
        strategy = "flat",
      },
    },
    ["core.gtd.base"] = {
      config = {
        workspace = "home",
      },
    },
    ["core.integrations.telescope"] = {},
  },
}
