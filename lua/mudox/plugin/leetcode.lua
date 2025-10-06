local arg = "leetcode"

return {
  "kawre/leetcode.nvim",
  -- dir = "~/Git/neovim-plugins/leetcode.nvim", -- HACK: improve UI
  dependencies = {
    "telescope.nvim",
    "plenary.nvim",
    "nui.nvim",
    "nvim-treesitter",
    "nvim-notify",
    "mini.nvim",
  },
  lazy = not (vim.fn.argc() == 1 and vim.fn.argv(0) == arg),
  opts = {
    arg = arg,
    lang = "rust",
  },
}
