local keys = {
  { "<leader>x<Space>", "<Cmd>TroubleToggle<Cr>", desc = "[Trouble] Toggle previous" },

  { "<leader>xx", "<Cmd>TroubleToggle document_diagnostics<Cr>", desc = "[Trouble] Document diagnostics" },
  { "<leader>xX", "<Cmd>TroubleToggle workspace_diagnostics<Cr>", desc = "[Trouble] Workspace diagnostics" },

  { "<leader>xl", "<Cmd>TroubleToggle loclist<Cr>", desc = "[Trouble] Loclist" },
  { "<leader>xq", "<Cmd>TroubleToggle quickfix<Cr>", desc = "[Trouble] Quickfix" },

  { "<leader>xr", "<Cmd>TroubleToggle lsp_references<Cr>", desc = "[Trouble] References" },
}

return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  opts = { use_diagnostic_signs = true },
  keys = keys,
}
