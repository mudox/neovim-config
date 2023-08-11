-- vim: fdm=marker fmr=\ 〈,\ 〉

local function setup_highlights()
  vim.api.nvim_set_hl(0, "NvimTreeOpenedFile", { fg = "#FFFFFF" })
end

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

local function config(_, options)
  require("nvim-tree").setup(options)
  setup_highlights()
end

return {
  "kyazdani42/nvim-tree.lua",
  dependencies = "kyazdani42/nvim-web-devicons",
  cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle", "NvimTreeFindFile", "NvimTreeRefresh" },
  keys = {
    { "<M-p>", "<Cmd>NvimTreeFindFileToggle<Cr>", desc = "Nvim Tree (Find File) Toggle" },
    { "<C-S-p>", "<Cmd>NvimTreeFindFile!<Cr>", desc = "Nvim Tree (Find File) (Update Root)" },
  },
  opts = opts,
  config = config,
}
