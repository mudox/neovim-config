local config = function()
  local t = require("telescope")

  t.setup {
    extensions = {
      smart_open = {
        cwd_only = true,
        match_algorithm = "fzf",
        ignore_patterns = {
          "*.git/*",
          "*/tmp/*",
          ".obsidian/*",
        },
        mappings = {
          i = {
            ["<C-w>"] = { "<C-S-w>", type = "command" }, -- override: delete opened buffer
          },
        },
      },
    },
  }

  t.load_extension("smart_open")
end

local keys = {
  { K.p("<Space>"), require("mudox.plugin.telescope.util").smart_open, desc = "[telescope] smart files" },
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
