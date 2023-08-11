local opts = function()
  local i = require("mudox.ui").icons

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

    hooks = {
      diff_buf_read = function()
        -- ISSUE: right window guidlines remain after disabling.
        vim.cmd([[
      IndentBlanklineDisable 
      ]])
      end,
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
