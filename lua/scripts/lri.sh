#!/usr/bin/env bash

luarocks --lua-version 5.1 --tree ~/.config/nvim/lua/rocks install --no-doc --force "$1"
