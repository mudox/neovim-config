
url = 'dyng/ctrlsf.vim'

event = 'VimEnter'

function config()
  vim.cmd [[
  cabbrev sf CtrlSF
  ]]

  local nplug = require('keymap').nplug
  local vplug = require('keymap').vplug

  -- search immediately
  nplug(',sf', 'CtrlSFCwordExec')
  vplug(',sf', 'CtrlSFVwordExec')
  nplug(',ss', 'CtrlSFCCwordExec')

  -- put on command line
  vplug(',s:', 'CtrlSFVwordPath')
  nplug(',s:', 'CtrlSFCwordPath')

  -- first try locating project root, starting from current file path
  -- if not found, fallback to current file path
  vim.g.ctrlsf_default_root = 'project+ff'

  -- more compat layout
  vim.g.ctrlsf_indent = 2

  -- enable regex search by defaults
  vim.g.ctrlsf_regex_pattern = 1
end
