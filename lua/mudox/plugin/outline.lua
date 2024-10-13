return {
  "hedyhli/outline.nvim",
  cmd = { "Outline", "OutlineOpen" },
  keys = { -- Example mapping to toggle outline
    { ",wo", "<Cmd>Outline!<Cr>", desc = "[Outline] Toggle" },
  },
  opts = {
    symbols = {
      -- filter = {
      --   default = { "String", exclude = true },
      -- },

      icon_fetcher = function(kind)
        return vim.fn.trim(require("mudox.ui.kind")[kind])
      end,

      icon_source = "lspkind",
    },
    symbol_folding = {
      markers = { I.chevron.right, I.chevron.down },
    },
    outline_window = {
      auto_jump = true,
      hide_cursor = true,
    },
    preview_window = {
      border = "none",
      winhl = "NormalFloat:NormalFloat",
    },
    keymaps = {
      up_and_jump = "<C-p>",
      down_and_jump = "<C-n>",
    },
  },
}
