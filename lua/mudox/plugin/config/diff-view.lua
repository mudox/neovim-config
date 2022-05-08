local i = require("mudox.ui").icons

local opts = {
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

require("diffview").setup(opts)

local ncmd = require("mudox.keymap").ncmd
ncmd("<M-/>d", "DiffviewOpen")
