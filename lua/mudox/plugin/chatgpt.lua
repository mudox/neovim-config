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
  config = function()
    vim.cmd([[ let $OPENAI_API_KEY = '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' ]])
    require("chatgpt").setup()
  end,
}
