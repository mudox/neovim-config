-- stylua: ignore start
local open  = '┤'
-- local dash  = '―'
local dash  = '―'
local fill  = ' '
local close = '├'
-- stylua: ignore end

local opts = {
  keep_indentation = false,
  fill_char = fill,
  sections = {
    left = {
      function()
        return dash:rep(vim.v.foldlevel + 1)
      end,
      open,
      "content",
    },
    right = {
      " ",
      "number_of_folded_lines",
      ": ",
      "percentage",
      " " .. close .. dash:rep(2),
    },
  },
}

require("pretty-fold").setup(opts)
