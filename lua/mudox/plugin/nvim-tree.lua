local function setup_highlights()
  vim.api.nvim_set_hl(0, "NvimTreeOpenedFile", { fg = "#FFFFFF" })
end

local function opts()
  local i = require("mudox.ui.icon")

  -- stylua: ignore
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

  -- stylua: ignore
  local git = {
    unstaged     = "!",
    staged       = "+",
    unmerged     = "u",
    renamed      = "r",
    untracked    = "?",
    deleted      = "x",
  }

  for k, icon in pairs(git) do
    icon = icon:gsub("^%s+", "") -- trim prefixing spaces
    icon = icon:gsub("%s+$", "") -- trim trailing spaces
    git[k] = icon
  end

  -- stylua: ignore
  local glyphs = {
    default        = "",
    symlink        = "",
    git            = git,
    folder         = folder,
  }

  return {
    sort_by = "extension",
    view = {
      signcolumn = "no",
      width = 40,
    },
    filters = {
      dotfiles = true,
    },
    renderer = {
      group_empty = true,
      highlight_opened_files = "name",
      root_folder_label = false,
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

local function config()
  require("nvim-tree").setup(opts())
  setup_highlights()
end

local kb = require("mudox.keyboard")
-- stylua: ignore
local keys = {
  { "<M-p>",    "<Cmd>NvimTreeFindFileToggle<Cr>", desc = "[NvimTree] Toggle"      },
  { kb.cs["p"], "<Cmd>NvimTreeFindFile!<Cr>",      desc = "[NvimTree] Reveal file" },
}

return {
  "kyazdani42/nvim-tree.lua",
  dependencies = "nvim-web-devicons",
  event = "VeryLazy", -- HACK: fix keymap load failure after restoring session
  keys = keys,
  config = config,
}