local opts = function()
  local i = require("mudox.ui.icon")

  return {
    enhanced_diff_hl = false,

    icons = {
      folder_closed = i.folder.closed,
      folder_open = i.folder.open,
    },

    signs = {
      fold_closed = i.chevron.right,
      fold_open = i.chevron.down,
    },
  }
end

-- stylua: ignore
local keys = {
  { "<Tab>d", function() require("mudox.lab.tabman").open("DiffviewOpen", "diffview") end,     desc = "[Diffview] Open",     },
  { "<Tab>D", function() require("mudox.lab.tabman").recreate("DiffviewOpen", "diffview") end, desc = "[Diffview] Recreate", },
}

return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = keys,
  opts = opts,
}
