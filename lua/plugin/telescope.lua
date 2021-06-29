url = 'nvim-telescope/telescope.nvim'

requires = {
  -- ? `opt = true`
  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
}

after = {'plenary.nvim', 'popup.nvim'}

keys = {
  '<Space>r',
  '<Space>/',

  '<C-p>',

  '<C-t><C-t>',
  '<C-t>r',
  '<C-t>f',
  '<C-t>F',
  '<C-t>/',
  '<C-t>g',
  '<C-t>g',
  '<C-t>G',
  '<C-t>d',
  '<C-t>D',
  '<C-t>.',
  '<C-t>o',
}
