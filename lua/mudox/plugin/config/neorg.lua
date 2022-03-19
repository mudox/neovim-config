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

local concealer_icons = {
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
  quote = {
    level_1 = {
      icon = "┃",
    },
    level_2 = {
      icon = "┃",
    },
    level_3 = {
      icon = "┃",
    },
    level_4 = {
      icon = "┃",
    },
    level_5 = {
      icon = "┃",
    },
    level_6 = {
      icon = "┃",
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
    example_gtd = "~/Git/Learn/example_workspaces/gtd",
  },
  default_workspace = "home",
  autodir = true,
  index = "index.norg",
}

-- 〉

require("neorg").setup {
  load = {
    ["core.defaults"] = {},
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
        workspace = "example_gtd",
      },
    },
  },
}
