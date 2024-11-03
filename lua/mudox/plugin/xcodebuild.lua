return {
  "wojciech-kulik/xcodebuild.nvim",
  dependencies = {
    "telescope.nvim",
    "nui.nvim",

    -- optional
    "nvim-tree.lua",
    "oil.nvim",
    "nvim-treesitter",
  },
  config = function()
    require("xcodebuild").setup {
      -- put some options here or leave it empty to use default settings
    }
  end,
}
