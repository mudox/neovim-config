-- vim: fdm=marker fmr=\ 〈,\ 〉

-- Mappings 〈

local k = require('keymap')
local ncmd = k.ncmd

local prefix = ',t'

-- builtin
ncmd(prefix .. ',', 'Telescope builtin')

-- files
ncmd('<C-p>',          'Telescope find_files')

-- recent files
ncmd('<Space>r',       'Telescope oldfiles')

ncmd(prefix .. 'f',    'Telescope git_files')

ncmd(prefix .. '/',    'Telescope file_browser')

-- grep string under cursor
ncmd(prefix .. 'g',    'Telescope grep_string')
ncmd(prefix .. 'G',    'Telescope live_grep')

ncmd(prefix .. 's',    'Telescope treesitter')

-- lsp diagnostics
ncmd(prefix .. 'd',    'Telescope lsp_document_diagnostics')
ncmd(prefix .. 'D',    'Telescope lsp_workspace_diagnostics')

-- lsp code actions
ncmd(prefix .. '.',    'Telescope lsp_code_actions')

-- vim options
ncmd(prefix .. 'o',    'Telescope vim_options')

-- coc

ncmd('<BS>c',          'Telescope coc commands')

-- 〉

-- Setup 〈

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
  pickers = {
    hidden = true,
  },
}

-- 〉

require('telescope').load_extension('fzf')

require('telescope').load_extension('coc')
ncmd(prefix .. 'cc', 'Telescope coc commands')
ncmd(prefix .. 'ca', 'Telescope coc code_actions')
ncmd(prefix .. 'cs', 'Telescope coc document_symbols')
ncmd(prefix .. 'cS', 'Telescope coc workspace_symbols')

require('telescope').load_extension('aerial')
ncmd(prefix .. 'a', 'Telescope aerial')
