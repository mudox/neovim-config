local function hide_cursor()
  U.on("BufEnter", function()
    local def = vim.api.nvim_get_hl(0, { name = "Cursor" })
    vim.api.nvim_set_hl(0, "Cursor", vim.tbl_extend("force", def, { blend = 100 }))
  end, { pattern = "NvimTree*" })

  U.on("BufLeave", function()
    local def = vim.api.nvim_get_hl(0, { name = "Cursor" })
    vim.api.nvim_set_hl(0, "Cursor", vim.tbl_extend("force", def, { blend = 0 }))
  end, { pattern = "NvimTree*" })
end

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

  -- stylua: ignore
  local keys_to_del = {
    "s",     -- system open
    "<C-e>", -- replace in tree window
    "<Tab>", -- preview
    "<C-t>", -- open in tabpage
  }
  for _, k in ipairs(keys_to_del) do
    vim.keymap.del("n", k, { buffer = bufnr }) -- replace tree buffer
  end

  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end

  vim.keymap.set("n", "<C-Cr>", function()
    local node = require("nvim-tree.lib").get_node_at_cursor()
    if not node or node.name == ".." or node.nodes then
      return
    end

    local path = node.link_to or node.absolute_path
    X.layout.main:open(path)
  end, opts("open in main"))

  vim.keymap.set("n", "<C-S-Cr>", function()
    local node = require("nvim-tree.lib").get_node_at_cursor()
    if not node or node.name == ".." or node.nodes then
      return
    end

    local path = node.link_to or node.absolute_path
    X.layout.secondary:open(path)
  end, opts("open in secondary"))
end

local function opts()
  hide_cursor()

  -- stylua: ignore
  local folder = {
    arrow_open     = I.chevron.down,
    arrow_closed   = I.chevron.right,

    default        = I.folder.closed,
    open           = I.folder.open,

    empty          = I.folder.empty,
    empty_open     = I.folder.empty_open,

    symlink        = I.folder.symlink,
    symlink_open   = I.folder.symlink_open,
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
