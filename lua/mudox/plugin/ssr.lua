return {
  "cshuaimin/ssr.nvim",
  -- stylua: ignore
  keys = { { "\\S", function() require("ssr").open() end, desc = "[SSR] Open", } },
  opts = {
    border = "single",
  },
}
