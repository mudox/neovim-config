#!/usr/bin/env zsh
set -euo pipefail

session_name='Neovim'
window_name='Plugins'
window="${session_name}:${window_name}"

if tmux has-session -t "${window}" >/dev/null 2>&1; then
  tmux switch-client -t "${window}"
	exit 0
fi

source ${MDX_TMUX_DIR}/sessions/lib/utils.zsh

local pane_title='  Plugins'
local dir=~/.local/share/nvim/site/mdx_nvim_mode/lsp/pack/packer
window

tmux switch-client -t "${window}"
