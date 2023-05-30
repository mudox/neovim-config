return {
  "Bekaboo/dropbar.nvim",
  event = { "BufRead", "BufNewFile" },
  keys = {
    {
      "<M-.>",
      function()
        require("dropbar.api").pick()
      end,
      desc = "Enter Dropbar Pick Mode",
    },
  },
}
