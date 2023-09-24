return {
  "windwp/nvim-spectre",
  keys = {
    {
      "\\s",
      function()
        require("spectre").open()
      end,
      desc = "[Spectre] Replace in files",
    },
  },
}
