local opts = {
  -- integrate with tree-sitter
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },

  disable_filetype = { "TelescopePrompt", "snacks_picker_input", "spectre_panel" },
  disable_in_visualblock = true,

  fast_wrap = {
    map = "<M-o>",
  },
}

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = opts,
}
