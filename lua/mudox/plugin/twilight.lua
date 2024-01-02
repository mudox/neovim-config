return {
  "folke/twilight.nvim",
  cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
  keys = { { "cot", "<Cmd>Twilight<Cr>", "[Twilight] Toggle" } },
  opts = {
    context = 20,
  },
}
