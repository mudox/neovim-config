-- @module tmux
local tmux = {}

local sx = require('pl.stringx')
local k = require('keymap')

local function shell_command()
  local f = vim.fn.findfile('tmux-test', '.;')

  if f then
    return 'sh ' .. f
  else
    return 'zsh'
  end
end

local function create_test_pane()
  local cmd_template = [[
  silent! !tmux split-window -h %s
  silent! !tmux set-option -p remain-on-exit
  ]]

  local cmd = cmd_template:format(shell_command())

  vim.cmd(cmd)
end

-- return panes count of current window
local function pane_count()
  local out = io.popen([[tmux list-panes | wc -l]], 'r')
  return tonumber(out:read('*a'))
end

local function respawn_test_pane()
  local cmd_template = [[
  silent! !tmux respawn-pane -k -t {right}
  silent! !tmux send-keys -t {right} '%s' C-m
  ]]

  local cmd = cmd_template:format(shell_command())

  vim.cmd(cmd)
end

function tmux.test_in_right_pane()
  vim.cmd [[cd %:p:h]]

  if not os.getenv('TMUX') then
    print 'not in a tmux environment, abort'
    return
  end

  if pane_count() == 1 then
    create_test_pane()
  else
    respawn_test_pane()
  end
end

k.ncmd('<BS>t', [[lua require('tmux').test_in_right_pane()]])

-- TODO: watch & respawn

-- TODO: timer based respawning

return tmux
