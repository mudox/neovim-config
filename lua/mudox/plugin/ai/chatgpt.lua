return {
  "jackMort/ChatGPT.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions", "ChatGPTRun" },
  keys = {
    { "<Space>c", "<Cmd>ChatGPT<Cr>", desc = "ChatGPT" },
  },
  opts = {
    api_key_cmd = "op read op://Personal/OpenAI/ChatGPT.nvim",
  },
  cond = false, -- seems unactive
}
