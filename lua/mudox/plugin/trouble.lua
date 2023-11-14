-- stylua: ignore
local keys = {
  { "<Space>", "",                      "Toggle previous",       },

  { "x",       "document_diagnostics",  "Document diagnostics",  },
  { "X",       "workspace_diagnostics", "Workspace diagnostics", },

  { "l",       "loclist",               "Loclist",               },
  { "q",       "quickfix",              "Quickfix",              },

  { "r",       "lsp_references",        "References",            },
}

keys = K.lazy_keys(keys, {
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
