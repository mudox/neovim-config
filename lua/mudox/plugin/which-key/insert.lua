-- stylua: ignore
return {
  { "<C-k>",    group = "insert leader" },

  mode = "i",
  {
    { "<C-;>", "<Esc>A;<Cr>",  desc = "End line with `;<Cr>`" },
    { "<C-,>", "<Esc>A,<Cr>",  desc = "End line with `,<Cr>`" },
  },
}
