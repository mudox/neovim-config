return {
  "stevearc/oil.nvim",
  keys = {
    {
      "<Space>o",
      function()
        require("oil").open()
      end,
      desc = "Oil (Parent Directory)",
    },
  },
  cmd = "Oil",
  opts = true,
}
