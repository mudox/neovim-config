#!/usr/bin/env zsh
set -euo pipefail

plugin_dirs=()

root_dir="${HOME}/.local/share/nvim/site/mdx_nvim_mode/lsp/pack/packer"
plugin_dirs+=($(fd -d1 -td '.*' "${root_dir}"/{start,opt}/))

root_dir="${HOME}/.local/share/nvim/site/pack/mudox"
plugin_dirs+=($(fd -d1 -td '.*' "${root_dir}"/{start,opt}/))

dir=$(for path in "${plugin_dirs[@]}"; do
	echo "${path:t}\t${path}"
done | fzf --nth=1 --with-nth=1 | awk '{print $2}')

name="${dir:t}"
name="${name#nvim-}"
name="${name%.nvim}"
name="${name:gs/_/-}"
name="${(C)name}"

window="Neovim:${name}"
if tmux has-session -t "${window}" &>/dev/null; then
	tmux switch-client -t "${window}"
else
	tmux new-window \
	-t 'Neovim'     \
	-n "${name}"    \
	-c "${dir}" 
fi
