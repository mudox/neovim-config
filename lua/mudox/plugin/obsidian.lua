local opts = {
  legacy_commands = false,

  workspaces = {
    {
      name = "mudox",
      path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/mudox",
    },
  },

  daily_notes = {
    folder = "Daily",
    date_format = "%Y/%Y-%m-%d",
  },
}

-- stylua: ignore
local function k(key) return K.p("n") .. key end

local function keys()
  -- stylua: ignore
  return {
    { k"<Cr>", K.c"Obsidian today", desc = "open today"       },
    { k"o",    K.c"Obsidian open",  desc = "open in obsidian" },
  }
end

return {
  "obsidian-nvim/obsidian.nvim",
  ft = "markdown",
  cmd = "Obsidian",
  keys = keys,
  opts = opts,
}
