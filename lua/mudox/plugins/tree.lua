-- vim: fdm=marker fmr=\ 〈,\ 〉

local function opts()
  local i = require("mudox.ui").icons

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
  -- stylua: ignore end

  for k, icon in pairs(folder) do
    icon = icon:gsub("^%s+", "") -- trim prefixing spaces
    icon = icon:gsub("%s+$", "") -- trim trailing spaces
    folder[k] = icon
  end

  -- stylua: ignore start
  local git = {
    unstaged     = "!",
    staged       = "+",
    unmerged     = "u",
    renamed      = "r",
    untracked    = "?",
    deleted      = "x",
  }
  -- stylua: ignore end

  for k, icon in pairs(git) do
    icon = icon:gsub("^%s+", "") -- trim prefixing spaces
    icon = icon:gsub("%s+$", "") -- trim trailing spaces
    git[k] = icon
  end

  -- stylua: ignore start
  local glyphs = {
    default        = "",
    symlink        = "",
    git            = git,
    folder         = folder,
  }
  -- stylua: ignore end

  -- 〉

  return {
    view = {
      signcolumn = "no",
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
        padding = "  ",
        git_placement = "after",
        glyphs = glyphs,
      },
      special_files = {},
    },
    actions = {
      remove_file = {
        close_window = false,
      },
    },
    hijack_directories = {
      enable = false,
    }, -- for `dirbuf.nvim`
  }
end

local function config(_, options)
  require("nvim-tree").setup(options)

  local k = require("mudox.lib.keymap")
  k.ncmd("<M-p>", "NvimTreeFindFileToggle")
end

return {
  "kyazdani42/nvim-tree.lua",
  dependencies = "kyazdani42/nvim-web-devicons",
  cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFindFile", "NvimTreeFindFileToggle" },
  keys = "<M-p>",
  opts = opts,
  config = config,
}
