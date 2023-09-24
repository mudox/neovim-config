return {
  "AckslD/nvim-trevJ.lua",
  -- event = { "BufRead", "BufNewFile" },
  keys = {
    {
      "\\j",
      function()
        require("trevj").format_at_cursor()
      end,
      desc = "[TrevJ] split or join",
    },
  },
  opts = true,
}
