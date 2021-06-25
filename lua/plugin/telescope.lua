url = 'nvim-telescope/telescope.nvim'

requires = {
  -- ? `opt = true`
  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
}

after = {'plenary.nvim', 'popup.nvim'}

keys = {
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

function config()
  local k = require('keymap')
  local ncmd = k.ncmd

  local prefix = '<C-t>'

  --
  -- builtin
  --

  ncmd(prefix .. prefix, 'Telescope builtin')

  -- files
  ncmd('<C-p>', 'Telescope find_files')
  ncmd(prefix .. 'r', 'Telescope oldfiles')
  ncmd(prefix .. 'f', 'Telescope find_files')
  ncmd(prefix .. 'F', 'Telescope git_files')
  ncmd(prefix .. '/', 'Telescope file_browser')

  -- grep string under cursor
  ncmd(prefix .. 'g', 'Telescope grep_string')
  ncmd(prefix .. 'G', 'Telescope live_grep')

  --
  -- lsp
  --

  -- lsp diagnostics
  ncmd(prefix .. 'd', 'Telescope lsp_document_diagnostics')
  ncmd(prefix .. 'D', 'Telescope lsp_workspace_diagnostics')

  -- lsp code actions
  ncmd(prefix .. '.', 'Telescope lsp_code_actions')

  --
  -- vim
  --

  -- options
  ncmd(prefix .. 'o', 'Telescope vim_options')

  --
  -- setup
  --

  require('telescope').setup {
    defaults = {
      -- vimgrep_arguments = {
      -- 'rg',
      -- '--color=never',
      -- '--no-heading',
      -- '--with-filename',
      -- '--line-number',
      -- '--column',
      -- '--smart-case'
      -- },
      -- prompt_position = "bottom",
      -- prompt_prefix = "> ",
      -- selection_caret = "> ",
      -- entry_prefix = "  ",
      -- initial_mode = "insert",
      -- selection_strategy = "reset",
      -- sorting_strategy = "descending",
      -- layout_strategy = "horizontal",
      -- layout_defaults = {
      -- horizontal = {
      -- mirror = false,
      -- },
      -- vertical = {
      -- mirror = false,
      -- },
      -- },
      -- file_sorter =  require'telescope.sorters'.get_fuzzy_file,
      -- file_ignore_patterns = {},
      -- generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
      -- shorten_path = true,
      -- winblend = 0,
      -- width = 0.75,
      -- preview_cutoff = 120,
      -- results_height = 1,
      -- results_width = 0.8,
      -- border = {},
      borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
      -- borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'},
      -- color_devicons = true,
      -- use_less = true,
      -- set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
      -- file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
      -- grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
      -- qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

      -- Developer configurations: Not meant for general override
      -- buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker

      -- extensions
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = false, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    },
  }

  require('telescope').load_extension('fzf')
end
