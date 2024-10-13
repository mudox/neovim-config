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
  opts = {
    workspaces = {
      {
        name = "Mudox",
        path = "~/Documents/Obsidian/Mudox",
      },
    },
  },
  cond = false,
}
