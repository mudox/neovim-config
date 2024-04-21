local function c(cmd)
  return "<Cmd>" .. cmd .. "<Cr>"
end

-- stylua: ignore
local nvim = {
  name = "+neovim view",

  -- TODO: my own custom info dashboards
  a         = { c "args",            "Arguments"             },
  B         = { c "buffers!",        "Buffers!"              },
  b         = { c "buffers",         "Buffers"               },
  c         = { c "ascii",           "ASCII"                 },
  g         = {   "8<C-G>",          "Buffer info"           },
  I         = { c "Inspect!",        "Inspect!"              },
  i         = { c "Inspect",         "Inspect"               },
  j         = { c "jumps",           "Jumps"                 },
  l         = { c "lopen",           "Loclist"               },
  m         = { c "marks",           "Marks"                 },
  o         = { c "options",         "Options"               },
  q         = { c "copen",           "Quickfix"              },
  r         = { c "registers",       "Registers"             },
  s         = { c "scriptnames",     "Loaded scripts"        },
  t         = { c "InspectTree",     "Inspect tree"          },
  u         = { c "undolist",        "Undo list"             },
  v         = { c "messages",        "Messages"              },
  V         = { c "verbose version", "Version"               },

  ["<Tab>"] = { c "tabs",            "Tabpages"              },
  ["="]     = { c "EditQuery",       "TreeSitter playground" },
}

-- stylua: ignore
local plugin = {
  name = "+plugin view",

  p = { c "Lazy",     "Plugins"          },
  k = { c "WhichKey", "WhichKey keymaps" },
}

return {
  nvim = nvim,
  plugin = plugin,
}
