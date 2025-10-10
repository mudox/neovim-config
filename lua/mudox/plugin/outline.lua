return {
  "hedyhli/outline.nvim",
  cmd = { "Outline", "OutlineOpen" },
  keys = { -- Example mapping to toggle outline
    { K.p"wo", "<Cmd>Outline!<Cr>", desc = "[Outline] Toggle" },
  },
  opts = {
    symbols = {
      icon_fetcher = function(kind)
        return vim.fn.trim(require("mudox.ui.kind")[kind])
      end,
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
