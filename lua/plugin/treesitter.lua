url = 'nvim-treesitter/nvim-treesitter'

event = {'VimEnter'}

run = ':TSUpdate'

function config()
  require('nvim-treesitter.configs').setup {
    ensure_installed = 'all', -- one of "all", "language", or a list of languages
    ignore_install = {
      'haskell', -- see https://github.com/nvim-treesitter/nvim-treesitter/issues/1030
    },

    highlight = {enable = true, disable = {}},

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'yv',
        node_incremental = 'v',
        scope_incremental = 's',
        node_decremental = 'V',
      },
    },

    indent = {enable = true, disable = {'python', 'rust'}},

    textobjects = {
      select = {
        enable = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',

          -- Or you can define your own textobjects like this
          ['iF'] = {
            python = '(function_definition) @function',
            cpp = '(function_definition) @function',
            c = '(function_definition) @function',
            java = '(method_declaration) @function',
          },
        },
      },

      -- swap paramters
      swap = {
        enable = true,
        swap_next = {['<leader>sn'] = '@parameter.inner'},
        swap_previous = {['<leader>sp'] = '@parameter.inner'},
      },

      -- move to start|end of function|class
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {[']m'] = '@function.outer', [']]'] = '@class.outer'},
        goto_next_end = {[']M'] = '@function.outer', [']['] = '@class.outer'},
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },

      -- press shorcut twice to show floating window
      lsp_interop = {
        enable = true,
        peek_definition_code = {
          ['df'] = '@function.outer',
          ['dF'] = '@class.outer',
        },
      },
    },
  }
end
