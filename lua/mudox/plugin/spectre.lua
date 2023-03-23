return {
  "windwp/nvim-spectre",
  keys = {
    {
      "\\s",
      function()
        require("spectre").open()
      end,
      desc = "Replace in files (Spectre)",
    },
  },
}
