vim.g.sandwich_no_default_key_mappings = 1

local k = require("mudox.keymap")
local prefix = "<M-'>"

-- Add
k.nplug(prefix .. "a", "(sandwich-add)")
k.xplug(prefix, "(sandwich-add)")

-- Delete
k.nplug(prefix .. "d", "(sandwich-delete)")
k.nplug(prefix .. "db", "(sandwich-delete-auto)")

-- Replace
k.nplug(prefix .. "r", "(sandwich-replace)")
k.nplug(prefix .. "rb", "(sandwich-replace-auto)")
