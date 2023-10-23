local opts = function()
  local i = require("mudox.ui.icon")

  return {
    enhanced_diff_hl = false,

    icons = {
      folder_closed = i.folder.default,
      folder_open = i.folder.open,
    },

    signs = {
      fold_closed = i.collapsed,
      fold_open = i.expanded,
    },
  }
end

return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<Space>d", "<Cmd>DiffviewOpen<Cr>", desc = "Diff View" },
  },
  opts = opts,
}
