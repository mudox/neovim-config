install = [[
Plug 'https://github.com/tmsvg/pear-tree.git'
]]

function confi()
  vim.g.pear_tree_smart_openers = 1
  vim.g.pear_tree_smart_closers = 1
  vim.g.pear_tree_smart_backspace = 1
  vim.g.pear_tree_timeout = 60

  vim.g.pear_tree_ft_disabled = { "clap_input" }
end
