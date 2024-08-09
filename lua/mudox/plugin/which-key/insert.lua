-- stylua: ignore
return {
  mode = "i",
  {
    { "<C-k>", group = "insert leader" },

    { "<C-k>;", "<Esc>A;<Esc>", desc = "Insert `;` at line end" },
    { "<C-k>,", "<Esc>A,",      desc = "Insert `,` at line end" },
  },
}
