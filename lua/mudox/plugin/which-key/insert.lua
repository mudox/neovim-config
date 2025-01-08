-- stylua: ignore
return {
  mode = "i",
  {
    { "<C-k>",    group = "insert leader" },

    { "<C-;>", "<Esc>A;<Cr>",  desc = "End line with `;<Cr>`" },
    { "<C-,>", "<Esc>A,<Cr>",  desc = "End line with `,<Cr>`" },
  },
}
