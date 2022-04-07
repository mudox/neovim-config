#!/usr/bin/env zsh
set -euo pipefail

session_name='Neovim'
window_name='Snippets'
window="${session_name}:${window_name}"

if tmux has-session -t "${window}" >/dev/null 2>&1; then
  tmux switch-client -t "${window}"
	exit 0
fi

source ${MDX_TMUX_DIR}/sessions/lib/utils.zsh

pane_title='  Snippets'
dir=~/.local/share/nvim/site/pack/mudox/start/vim-mysnippets/LuaSnip
cmd='nvim init.lua'
window

tmux switch-client -t "${window}"
