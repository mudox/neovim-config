local surrounds = {
  -- fold
  z = {
    add = function()
      local prefix = vim.bo.commentstring
      if prefix == "" then
        prefix = "# %s"
      end
      local input = require("nvim-surround.config").get_input
      local label = input("Enter fold label: ")
      local open = { (prefix .. " 〈"):format(label), "" }
      local close = { "", (prefix .. " 〉"):format(label) }
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

-- stylua: ignore
local keys = {
  { "s=",       "<Plug>(nvim-surround-normal)",      remap = true, desc = "[surround] add"                         },
  { "s,",       "<Plug>(nvim-surround-normal)",      remap = true, desc = "[surround] add"                         },
  { "s<Space>", "siw",                               remap = true, desc = "[surround] add"                         },

  { "s\\",      "<Plug>(nvim-surround-change)",      remap = true, desc = "[surround] change"                      },
  { "s/",       "<Plug>(nvim-surround-change)",      remap = true, desc = "[surround] change"                      },
  { "s;",       "<Plug>(nvim-surround-change)",      remap = true, desc = "[surround] change"                      },

  { "s-",       "<Plug>(nvim-surround-delete)",      remap = true, desc = "[surround] delete"                      },
  { "s.",       "<Plug>(nvim-surround-delete)",      remap = true, desc = "[surround] delete"                      },

  { "q",        "<Plug>(nvim-surround-visual)",      remap = true, desc = "[surround] add",             mode = "x" },
  { "Q",        "<Plug>(nvim-surround-visual-line)", remap = true, desc = "[surround] add in new line", mode = "x" },
}

local opts = {
  surrounds = surrounds,
}

return {
  "kylechui/nvim-surround",
  keys = keys,
  opts = opts,
}
