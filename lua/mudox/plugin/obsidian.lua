-- TODO: learn this plugin

local pattern = vim.fn.expand("~") .. "/Documents/Obsidian/Mudox/**.md"
local event = {
  "BufReadPre " .. pattern,
  "BufNewFile " .. pattern,
}

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  event = event,
  dependencies = {
    "plenary.nvim",
    "nvim-cmp",
    "telescope.nvim",
    "nvim-treesitter",
  },
  opts = {
    workspaces = {
      {
        name = "Mudox",
        path = "~/Documents/Obsidian/Mudox",
      },
    },
  },
}
