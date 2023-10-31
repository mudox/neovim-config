return {
  "danielfalk/smart-open.nvim",
  branch = "0.2.x",
  dependencies = {
    "kkharji/sqlite.lua",
    "telescope.nvim",
    "telescope-fzf-native.nvim",
  },
  -- stylua: ignore
  keys = {
    { "<Space><Space>", require("mudox.plugin.telescope.util").smart_open, desc = "[Telescope] Smart open" },
  },
  config = function()
    local t = require("telescope")
    t.setup {
      extensions = {
        smart_open = {
          match_algorithm = "fzf",
        },
      },
    }
    t.load_extension("smart_open")
  end,
}
