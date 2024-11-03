local config = function()
  local t = require("telescope")

  t.setup {
    extensions = {
      smart_open = {
        match_algorithm = "fzf",
        ignore_patterns = {
          "*.git/*",
          "*/tmp/*",
          ".obsidian/*",
        },
      },
    },
  }

  t.load_extension("smart_open")
end

local keys = {
  { "<Space><Space>", require("mudox.plugin.telescope.util").smart_open, desc = "[Telescope] Smart open" },
}

return {
  "danielfalk/smart-open.nvim",
  branch = "0.3.x",
  dependencies = {
    "kkharji/sqlite.lua",
    "telescope.nvim",
    "telescope-fzf-native.nvim",
  },
  keys = keys,
  config = config,
}
