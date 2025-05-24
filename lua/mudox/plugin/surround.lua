local surrounds = {
  -- fold
  z = {
    add = function()
      local input = require("nvim-surround.config").get_input
      local label = input("Enter fold label: ")
      local open = { ("-- %s 〈"):format(label), "" }
      local close = { "", ("-- %s 〉"):format(label) }
      return { open, close }
    end,
  },
  -- disable formatting
  i = {
    add = function()
      local open = { "-- stylua: ignore start" }
      local close = { "-- stylua: ignore end" }
      return { open, close }
    end,
  },
}

local keys = {
  "ys", -- add
  "cs", -- change
  "ds", -- delete
  { "q", mode = "v", desc = "surround" },
  { "Q", mode = "v", desc = "surround" },
}

local opts = {
  keymaps = {
    visual = "q",
    visual_line = "Q",
  },

  surrounds = surrounds,
}

return {
  "kylechui/nvim-surround",
  keys = keys,
  opts = opts,
}
