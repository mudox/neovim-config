-- stylua: ignore
local keys = {
  { "<Space>", "<Cmd>TroubleToggle<Cr>",              "Toggle previous",       k = "r", },

  { "x",       "TroubleToggle document_diagnostics",  "Document diagnostics",           },
  { "X",       "TroubleToggle workspace_diagnostics", "Workspace diagnostics",          },

  { "l",       "TroubleToggle loclist",               "Loclist",                        },
  { "q",       "TroubleToggle quickfix",              "Quickfix",                       },

  { "r",       "TroubleToggle lsp_references",        "References",                     },
}

keys = require("mudox.util.keymap").lazy_keys(keys, {
  key_prefix = "<leader>x",
  main_cmd = "TroubleToggle",
  desc_prefix = "Trouble",
})

return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  opts = { use_diagnostic_signs = true },
  keys = keys,
}
