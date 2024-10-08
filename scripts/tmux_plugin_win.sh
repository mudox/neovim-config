#!/usr/bin/env bash
set -uo pipefail

unset NVIM

if ! tmux select-window -t "$1" &>/dev/null; then
  tmux new-window -n "$1" -c "$2" nvim
fi
