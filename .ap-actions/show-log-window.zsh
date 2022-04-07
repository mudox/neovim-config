#!/usr/bin/env zsh
set -euo pipefail

session_name='Neovim'
window_name=Log
window="${session_name}:${window_name}"

if tmux has-session -t "${window}" >/dev/null 2>&1; then
  tmux switch-client -t "${window}"
	exit 0
fi

source ${MDX_TMUX_DIR}/sessions/lib/utils.zsh

tail=(tail -n 100 -F)

# Pane 'Neovim'
pane_title='  Neovim'
dir="${HOME}/.cache/nvim"
cmd="${tail} -f log"
window

# Pane 'LSP'
pane_title='  LSP'
cmd="${tail} -f lsp.log"
pane

# Pane 'LSP Installer'
pane_title='  LSP Installer'
cmd="${tail} -f lsp-installer.log"
pane

# Pane 'Packer'
pane_title='  Packer'
cmd="${tail} -f packer.nvim.log"
pane

tmux select-layout -t "${window}" -E

tmux switch-client -t "${window}"
