vim.g.sandwich_no_default_key_mappings = 1

local k = require("mudox.keymap")
-- local prefix = "<M-'>"
local prefix = "'"

-- Add
k.nplug(prefix .. "a", "(sandwich-add)")
k.xplug(prefix, "(sandwich-add)")
k.xplug(prefix, "(sandwich-add)")

local chars = [[`"()]]
for i = 1, #chars do
  local c = chars:sub(i, i)
  k.xmap(c, "<Plug>(sandwich-add)" .. c)
end

-- Delete
k.nplug(prefix .. "d", "(sandwich-delete)")
k.nplug(prefix .. "db", "(sandwich-delete-auto)")

-- Replace
k.nplug(prefix .. "r", "(sandwich-replace)")
k.nplug(prefix .. "rb", "(sandwich-replace-auto)")
