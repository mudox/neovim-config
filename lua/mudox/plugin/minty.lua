return {
  "nvchad/minty",
  dependencies = "nvchad/volt",
  -- stylua: ignore
  keys = {
    { "<leader>ech", function() require("minty.huefy").open() end,  desc = "[Minty] huefy" },
    { "<leader>ecs", function() require("minty.shades").open() end, desc = "[Minty] shades" },
  },
}
