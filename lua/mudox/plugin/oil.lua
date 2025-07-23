local detail = false

local opts = {
  keymaps = {
    ["<C-s>"] = "actions.select_split",

    ["<C-v>"] = "actions.select_vsplit",
    ["<C-h>"] = false,

    ["<C-c>"] = false,
    ["q"] = "actions.close",

    ["<C-l>"] = false,
    ["<C-r>"] = "actions.refresh",

    ["gd"] = {
      desc = "Toggle file detail view",
      callback = function()
        detail = not detail
        if detail then
          require("oil").set_columns { "icon", "permissions", "size", "mtime" }
        else
          require("oil").set_columns { "icon" }
        end
      end,
    },
  },

  win_options = {
    winbar = "%!v:lua.dropbar()",
  },

  keymaps_help = {
    border = "none",
  },
  float = {
    padding = 2,
    border = "single",
    max_width = 0.7,
    max_height = 0.8,
  },
  preview = {
    border = "none",
  },
  progress = {
    border = "none",
  },
  ssh = {
    border = "none",
  },

  watch_for_changes = true,
}

return {
  "stevearc/oil.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>fo", function() require("oil").open() end, desc = "[Oil] Open", },
    { "<M-o>",      function() require("oil").open() end, desc = "[Oil] Open", },
  },
  cmd = "Oil",
  opts = opts,
}
