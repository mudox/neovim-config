-- vim: fdm=marker fmr=〈,〉

-- Keymaps 〈

local builtin = require("telescope.builtin")
local dropdown = require("telescope.themes").get_dropdown
local cursor = require("telescope.themes").get_cursor

local ncmd = require("mudox.keymap").ncmd
local nmap = require("mudox.keymap").nmap

-- Files
nmap("<C-p>", function()
  if not pcall(builtin.git_files, {}) then
    builtin.find_files {}
  end
end)

-- Grep
ncmd("g/", "Telescope live_grep") -- interactive grep

-- Symbols
ncmd("<M-8>", "Telescope lsp_document_symbols")
ncmd("<M-9>", "Telescope lsp_dynamic_workspace_symbols")
ncmd("<M-i>", "Telescope treesitter")

-- 〉

-- Interface Keymaps 〈

local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
local mappings = {
  -- Insert mode
  i = {
    -- No normal mode
    ["<Esc>"] = actions.close,

    -- Clear prompt instead of scroll up
    ["<C-u>"] = false,

    -- Preview
    ["?"] = actions_layout.toggle_preview,

    -- Scrolling
    ["<C-f>"] = actions.results_scrolling_down,
    ["<C-b>"] = actions.results_scrolling_up,

    -- Split open
    -- By convention <C-x> and <C-s> are used for horizontal splitting
    ["<C-s>"] = actions.select_horizontal,
  },

  -- Normal mode
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

    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim", -- trim indentations
    },
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


load("neoclip")
-- 〉
