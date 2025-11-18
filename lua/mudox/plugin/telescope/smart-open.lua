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
  { K.p("<Space>"), require("mudox.plugin.telescope.util").smart_open, desc = "[Telescope] Files" },
}

return {
  "danielfalk/smart-open.nvim",
  dependencies = {
    "kkharji/sqlite.lua",
    "telescope-fzf-native.nvim",
  },
  keys = keys,
  config = config,
}
