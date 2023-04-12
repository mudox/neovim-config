local surrounds = {
  z = {
    add = function()
      local input = require("nvim-surround.config").get_input
      local label = input("Enter fold label: ")
      local open = { ("-- %s 〈"):format(label), "", "" }
      local close = { "", "", ("-- %s 〉"):format(label) }
      return { open, close }
    end,
  },
}

opts = {
  keymaps = {
    visual = ",s", -- `S` and `gs` conflicts with `leap.nvim`
    visual_line = ",S",
  },
  surrounds = surrounds,
}

return {
  "kylechui/nvim-surround",
  event = "BufRead, BufNewFile",
  opts = opts,
}
