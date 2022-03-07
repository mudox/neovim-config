#!/usr/bin/env zsh
set -euo pipefail

stylua init.lua
stylua lua/mudox/**/*.lua

[[ $? == 0 ]] && jack success 'Done'
