-- vim: fdm=marker fmr=\ 〈,\ 〉

-- Mappings  〈

local ncmd = require("mudox.keymap").ncmd
ncmd("<C-p>", "Telescope find_files")
ncmd("g/", "Telescope live_grep") -- interactive grep
ncmd("<Space>r", "Telescope oldfiles")

-- 〉

-- Interface Mappings  〈

local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
local mappings = {
  i = {
    ["?"] = actions_layout.toggle_preview,
    ["<C-f>"] = actions.results_scrolling_down,
    ["<C-b>"] = actions.results_scrolling_up,
  },
  n = {
    ["q"] = actions.close,
  },
}

-- 〉

-- Setup 〈

require("telescope").setup {
  defaults = {
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    -- borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'},

    mappings = mappings,
  },

  extensions = {

    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      },
    },

    termfinder = {
      mappings = {
        rename_term = "<C-r>",
        delete_term = "<C-x>",
        vertical_term = "<C-v>",
        horizontal_term = "<C-h>",
        float_term = "<C-f>",
      },
    },

    frecency = {
      db_root = stdpath.data .. "/sqlite",
      show_scores = false,
      show_unindexed = true,
      ignore_patterns = { "*.git/*", "*/tmp/*" },
      disable_devicons = false,
      workspaces = {
        ["dot"] = "/Users/mudox/.dotfiles",
        ["vi"] = "/Users/mudox/Git/neovim-config",
        ["tmux"] = "/Users/mudox/Git/tmux-config",
        ["hs"] = "/Users/mudox/Git/hs-config",
      },
    },
  },

  pickers = { hidden = true },
}

-- 〉

-- Extensions 〈

local function load(name)
  require("telescope").load_extension(name)
end

load("fzf")

load("aerial")

load("ui-select")

load("packer")

load("file_browser")

load("notify")

load("dap")

load("projects")

-- 〉
