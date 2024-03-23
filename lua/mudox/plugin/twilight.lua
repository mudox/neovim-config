return {
  "folke/twilight.nvim",
  cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
  keys = { { "cot", "<Cmd>Twilight<Cr>", desc = "[Twilight] Toggle" } },
  opts = {
    context = 20,
  },
}
