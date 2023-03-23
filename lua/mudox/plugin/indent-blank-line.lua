local styles = {}

styles.simple = function()
  vim.opt.listchars:append("space:·")
  vim.opt.listchars:append("eol:↴")

  require("indent_blankline").setup { show_end_of_line = true }
end

styles.rainbow = function()
  vim.cmd([[
      highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine
      highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine
      highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine
      highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine
      highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine
      highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine
    ]])

  vim.opt.listchars:append("space:·")
  vim.opt.listchars:append("eol:↴")

  require("indent_blankline").setup {
    space_char_blankline = " ",
    char_highlight_list = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
      "IndentBlanklineIndent3",
      "IndentBlanklineIndent4",
      "IndentBlanklineIndent5",
      "IndentBlanklineIndent6",
    },
  }
end

styles.fill = function()
  vim.cmd([[
      highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine
      highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine
    ]])

  require("indent_blankline").setup {
    char = "",
    char_highlight_list = { "IndentBlanklineIndent1", "IndentBlanklineIndent2" },
    space_char_highlight_list = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
    },
    show_trailing_blankline_indent = false,
  }
end

styles.highlight = function()
  vim.cmd([[highlight IndentBlanklineChar guifg=#333333]])

  vim.opt.listchars:append("space:·")
  vim.opt.listchars:append("eol:↴")

  require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = false,
    show_trailing_blankline_indent = true,
  }
end

local function config(_, opts)
  require("indent_blankline").setup(opts)
  styles.rainbow()

  -- hide guidelins initially, can turn on by `yoi` after
  vim.g.indent_blankline_enabled = 0
end

return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufRead", "BufNewFile" },
  keys = {
    { "yoi", "<Cmd>IndentBlanklineToggle<Cr>", desc = "Toggle Indent Guidelines" },
  },
  opts = {
    char = "│",
    filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
  },
  config = config,
}
