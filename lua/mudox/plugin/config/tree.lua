-- vim: fdm=marker fmr=〈,〉

local i = require("mudox.ui").icons

vim.g.nvim_tree_icon_padding = "  "
vim.g.nvim_tree_special_files = {}

-- Icons 〈

-- stylua: ignore start
local folder = {
  arrow_open     = i.expanded,
  arrow_closed   = i.collapsed,
  default        = i.folder.default,
  open           = i.folder.open,
  empty          = i.folder.empty,
  empty_open     = i.folder.empty_open,
  symlink        = i.folder.symlink,
  symlink_open   = i.folder.symlink_open,
}

for k, icon in pairs(folder) do
  icon = icon:gsub("^%s+", "") -- trim prefixing spaces
  icon = icon:gsub("%s+$", "") -- trim trailing spaces
  folder[k] = icon
end

vim.g.nvim_tree_icons = {
  default        = "",
  symlink        = "",
  git            = {
    unstaged     = "!",
    staged       = "+",
    unmerged     = "u",
    renamed      = "r",
    untracked    = "?",
    deleted      = "x",
  },
  folder         = folder,
  lsp            = {
    error        = i.error,
    warning      = i.warn,
    info         = i.info,
    hint         = i.hint,
  },
}
-- stylua: ignore end

-- 〉

local opts = {
  view = {
    hide_root_folder = true,
    width = 40,
  },
  filters = {
    dotfiles = true,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = "after",
    },
  },
}

require("nvim-tree").setup(opts)

local ncmd = require("mudox.keymap").ncmd

ncmd("<M-p>", "NvimTreeFindFileToggle")
