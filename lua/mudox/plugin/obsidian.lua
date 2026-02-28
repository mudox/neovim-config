-- ref: https://github.com/obsidian-nvim/obsidian.nvim/wiki

local opts = {
  legacy_commands = false,

  workspaces = {
    {
      name = "mudox",
      path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/mudox",
    },
  },

  templates = {
    folder = "/templates",
  },

  note = {
    template = "default.md",
  },

  daily_notes = {
    folder = "00-Daily",
    date_format = "%Y/%Y-%m-%d",
    template = "daily-note.md",
  },

  ui = {
    enabled = false,
  },

  footer = {
    enabled = false,
  },

  attachments = {
    folder = "/attachments",
  },

  checkbox = {
    order = { " ", "x" },
  },
}

-- stylua: ignore
local function k(key) return K.p("n") .. key end

local function keys()
  -- stylua: ignore
  return {
    { k"=", K.c"Obsidian today",     desc = "today"             },
    { k"[", K.c"Obsidian yesterday", desc = "yesterday"         },
    { k"]", K.c"Obsidian tomorrow",  desc = "tomorrow"          },
    { k"d", K.c"Obsidian dailies",   desc = "dailies"           },

    { k"n", K.c"Obsidian new",       desc = "new"               },
    { k"N", K.c"Obsidian new",       desc = "new from template" },
    { k"t", K.c"Obsidian template",  desc = "template"          },

    { k"o", K.c"Obsidian open",      desc = "open in obsidian"  },
  }
end

return {
  "obsidian-nvim/obsidian.nvim",
  ft = "markdown",
  cmd = "Obsidian",
  keys = keys,
  opts = opts,
}
