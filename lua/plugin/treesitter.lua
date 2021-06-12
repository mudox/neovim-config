install = [[
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
]]

function setup()
  require'nvim-treesitter.configs'.setup {
    ensure_installed = 'all', -- one of "all", "language", or a list of languages
    ignore_install = {
      'haskell', -- see https://github.com/nvim-treesitter/nvim-treesitter/issues/1030
    },

    highlight = {enable = true, disable = {}},

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<Space>v',
        node_incremental = 'v',
        scope_incremental = 's',
        node_decremental = 'V',
      },
    },

    indent = {enable = true, disable = {'python', 'rust'}},
  }
end
