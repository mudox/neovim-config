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
  -- stylue ignore lines
  i = {
    add = function()
      local open = { "-- stylua: ignore start" }
      local close = { "-- stylua: ignore end" }
      return { open, close }
    end,
  },
}

local opts = {
  keymaps = {
    -- `S` and `gs` conflicts with `leap.nvim`
    visual = "q",
    visual_line = "Q",
  },
  surrounds = surrounds,
}

return {
  "kylechui/nvim-surround",
  event = "BufRead, BufNewFile",
  opts = opts,
}
