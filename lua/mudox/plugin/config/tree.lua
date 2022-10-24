-- vim: fdm=marker fmr=\ 〈,\ 〉

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

-- Config 〈

local opts = {
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
  hijack_directories = false, -- for `dirbuf.nvim`
}

require("nvim-tree").setup(opts)

-- 〉

-- Keymaps 〈

local ncmd = require("mudox.keymap").ncmd

ncmd("<M-p>", "NvimTreeFindFileToggle")
ncmd("<M-/><M-p>", "NvimTreeFindFile")

-- 〉

-- Auto commands 〈

local gid = vim.api.nvim_create_augroup("MudoxNvimTree", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = gid,
  pattern = "NvimTree",
  callback = function(event)
    local nnop = require("mudox.keymap").nnop
    local keys = { "H", "L", "]b", "[b", "[f", "]f" }
    for _, key in ipairs(keys) do
      nnop(key, { buffer = event.buf })
    end
  end,
})

--〉
