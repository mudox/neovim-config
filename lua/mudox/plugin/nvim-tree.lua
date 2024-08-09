local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  -- local function add(lhs, rhs, desc)
  --   local opts = {
  --     desc = "nvim-tree: " .. desc,
  --     buffer = bufnr,
  --     noremap = true,
  --     silent = true,
  --     nowait = true,
  --   }
  --   vim.keymap.set("n", lhs, rhs, opts)
  -- end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.del("n", "<C-e>", { buffer = bufnr }) -- open in place
  vim.keymap.del("n", "<Tab>", { buffer = bufnr }) -- preview or open fold
  vim.keymap.del("n", "<C-t>", { buffer = bufnr }) -- tab open or open fold
end

local function opts()
  local i = require("mudox.ui.icon")

  -- stylua: ignore
  local folder = {
    arrow_open     = i.chevron.down,
    arrow_closed   = i.chevron.right,

    default        = i.folder.closed,
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

  -- for k, icon in pairs(git) do
  --   icon = icon:gsub("^%s+", "") -- trim prefixing spaces
  --   icon = icon:gsub("%s+$", "") -- trim trailing spaces
  --   git[k] = icon
  -- end

  -- stylua: ignore
  local glyphs = {
    default = "",
    symlink = "󰿨",
    git     = git,
    folder  = folder,
  }

  local renderer = {
    group_empty = true,
    highlight_opened_files = "name",
    root_folder_label = false,
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        folder = true,
        folder_arrow = false,
      },
      padding = " ",
      git_placement = "after",
      symlink_arrow = " 󰅂 ",
      glyphs = glyphs,
    },

    special_files = {},
  }

  return {
    on_attach = on_attach,
    sort_by = "extension",
    view = {
      signcolumn = "no",
    },
    filters = {
      dotfiles = true,
    },
    renderer = renderer,
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

-- stylua: ignore
local keys = {
  { "<M-p>",      "<Cmd>NvimTreeFindFileToggle<Cr>", desc = "[NvimTree] Toggle"      },
  { "<leader>fe", "<Cmd>NvimTreeFindFileToggle<Cr>", desc = "[NvimTree] Toggle"      },
  { "<leader>fv", "<Cmd>NvimTreeFindFile!<Cr>",      desc = "[NvimTree] Reveal file" },
}

return {
  "kyazdani42/nvim-tree.lua",
  dependencies = "nvim-web-devicons",
  keys = keys,
  opts = opts,
}
