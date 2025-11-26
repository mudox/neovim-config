return {
  "saghen/blink.indent",
  event = { "BufRead", "BufNewFile" },
  init = function()
    vim.g.indent_guide = false
  end,
  opts = {
    blocked = {
      filetypes = { include_defaults = true, "help" },
    },
  },
}
