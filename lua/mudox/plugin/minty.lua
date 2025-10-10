return {
  "nvchad/minty",
  dependencies = "nvchad/volt",
  -- stylua: ignore
  keys = {
    { K.p"ech", function() require("minty.huefy").open() end,  desc = "[Minty] huefy" },
    { K.p"ecs", function() require("minty.shades").open() end, desc = "[Minty] shades" },
  },
}
