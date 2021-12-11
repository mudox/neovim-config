---@diagnostic disable: lowercase-global
-- vim: fdm=marker fmr=〈,〉

-- below are 4 configs exerpted from https://github.com/lukas-reineke/indent-blankline.nvim/tree/master#simple

function simple()
  -- vim.opt.listchars:append('space:⋅')
  -- vim.opt.listchars:append('eol:↴')

  require('indent_blankline').setup {show_end_of_line = true}
end

function rainbow()
  vim.opt.termguicolors = true
  vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

  -- vim.opt.listchars:append('space:⋅')
  -- vim.opt.listchars:append('eol:↴')

  require('indent_blankline').setup {
    space_char_blankline = ' ',
    char_highlight_list = {
      'IndentBlanklineIndent1',
      'IndentBlanklineIndent2',
      'IndentBlanklineIndent3',
      'IndentBlanklineIndent4',
      'IndentBlanklineIndent5',
      'IndentBlanklineIndent6',
    },
  }
end

function background()
  vim.opt.termguicolors = true
  vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

  require('indent_blankline').setup {
    char = '',
    char_highlight_list = {'IndentBlanklineIndent1', 'IndentBlanklineIndent2'},
    space_char_highlight_list = {
      'IndentBlanklineIndent1',
      'IndentBlanklineIndent2',
    },
    show_trailing_blankline_indent = false,
  }
end

function highlight()
  vim.opt.listchars:append('space:⋅')
  -- vim.opt.listchars:append('eol:↴')

  require('indent_blankline').setup {
    space_char_blankline = ' ',
    show_current_context = true,
    show_current_context_start = true,
  }
end

vim.g.indent_blankline_filetype = {'lua', 'rust', 'swift', 'c', 'python'}
rainbow()
