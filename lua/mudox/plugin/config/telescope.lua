-- vim: fdm=marker fmr=\ 〈,\ 〉

-- Mappings  〈

local ncmd = require("mudox.keymap").ncmd
ncmd("<C-p>", "Telescope find_files")
ncmd("g/", "Telescope live_grep") -- interactive grep
ncmd("<M-i>", "Telescope lsp_document_symbols")

-- 〉

-- Interface Mappings  〈

local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
local mappings = {
  i = {
    -- Preview
    ["?"] = actions_layout.toggle_preview,

    -- Scrolling
    ["<C-f>"] = actions.results_scrolling_down,
    ["<C-b>"] = actions.results_scrolling_up,

    -- Split open
    -- By convention <C-x> and <C-s> are used for horizontal splitting
    ["<C-s>"] = actions.select_horizontal,
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
      require("telescope.themes").get_dropdown {},
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

load("live_grep_raw")

-- 〉
