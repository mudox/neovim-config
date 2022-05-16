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
local trouble = require("trouble.providers.telescope")
local mappings = {
  -- Insert mode
  i = {
    -- No normal mode
    ["<Esc>"] = actions.close,

    -- Clear prompt instead of scroll up
    ["<C-u>"] = false,

    -- Preview
    ["?"] = actions_layout.toggle_preview,
    ["<C-k>"] = actions.preview_scrolling_up,
    ["<C-j>"] = actions.preview_scrolling_down,

    -- Scrolling
    ["<C-b>"] = actions.results_scrolling_up,
    ["<C-f>"] = actions.results_scrolling_down,

    -- Split open
    -- By convention <C-s> are used for horizontal splitting
    ["<C-s>"] = actions.select_horizontal,

    ["<C-x>"] = trouble.open_with_trouble,
    ["<C-q>"] = trouble.smart_send_to_qflist,
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
    -- UI
    selection_caret = " ",
    prompt_prefix = " ",
    multi_icon = "│",

    -- Layout
    layout_strategy = "flex",
    layout_config = {
      prompt_position = "top",
    },

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
  -- NOTE: `load_extension` must be after `telescope.setup`
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

load("heading")

load("neoclip")
-- 〉
