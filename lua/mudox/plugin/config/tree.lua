local i = require("mudox.ui").icons

vim.g.nvim_tree_show_icons = {
  git = 0,
  folders = 1,
  folder_arrows = 1,
  files = 1,
}
vim.g.nvim_tree_icon_padding = "  "
vim.g.nvim_tree_special_files = {}

-- stylua: ignore start
vim.g.nvim_tree_icons = {
  default        = " ",
  symlink        = " ",
  git            = {
    unstaged     = "!",
    staged       = "+",
    unmerged     = "u",
    renamed      = "r",
    untracked    = "?",
    deleted      = "x",
  },
  folder         = {
    arrow_open   = i.expanded,
    arrow_closed = i.collapsed,
    default      = "",
    open         = "",
    empty        = "",
    empty_open   = "",
    symlink      = "",
    symlink_open = "",
  },
  lsp            = {
    error        = i.error,
    warning      = i.warn,
    info         = i.info,
    hint         = i.hint,
  },
}
-- stylua: ignore end

local opts = {}

require("nvim-tree").setup(opts)

local ncmd = require("mudox.keymap").ncmd

ncmd("<M-/>t", "NvimTreeFindFileToggle")
ncmd("<M-p>", "NvimTreeFindFileToggle")
