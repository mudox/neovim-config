return {
  "stevearc/oil.nvim",
  -- stylua: ignore
  keys = {
    { "<Space>bo", function() require("oil").open() end, desc = "Oil (Parent Directory)", },
  },
  cmd = "Oil",
  opts = true,
}
