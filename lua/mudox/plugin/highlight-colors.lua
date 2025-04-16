return {
  "brenoprata10/nvim-highlight-colors",
  keys = C.key.toggle .. "c", -- defined in mudox/plugin/snacks/toggle.lua
  config = function()
    require("nvim-highlight-colors").setup {
      render = "virtual",
      virtual_symbol_position = "inline",
      virtual_symbol = " ",
      virtual_symbol_suffix = "",

      exclude_filetypes = { "lazy", "help" },
    }

    -- off initially
    require("nvim-highlight-colors").turnOff()
  end,
}
