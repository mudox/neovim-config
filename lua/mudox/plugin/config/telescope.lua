-- vim: fdm=marker fmr=\ 〈,\ 〉

-- Mappings 〈
local k = require("mudox.keymap")
local ncmd = k.ncmd
local nlua = k.nlua

local function map(from, to)
  nlua(from, ('require("telescope").%s'):format(to))
end

local prefix = ",t"

-- builtin
---@diagnostic disable-next-line: lowercase-global
function _mdx_telescope_picker_builtin()
  local opts = {
    include_extensions = true,
  }
  require("telescope.builtin").builtin(opts)
end
ncmd(prefix .. ":", "lua _mdx_telescope_picker_builtin()")

-- resume last list
ncmd(prefix .. "<space>", "Telescope resume")

-- files
ncmd("<C-p>", "Telescope find_files")
ncmd(prefix .. "f", "Telescope git_files")

-- recent files
ncmd("<Space>r", "Telescope oldfiles")

-- grep
ncmd("g/", "Telescope live_grep") -- interactive grep
ncmd(prefix .. "g", "Telescope live_grep") -- interactive grep
ncmd(prefix .. "G", "Telescope grep_string") -- grep string under cursor

-- treesitter symbols
ncmd(prefix .. "s", "Telescope treesitter")

-- diagnostics
ncmd(prefix .. "?", "Telescope diagnostics bufnr=0")

-- lsp
ncmd(prefix .. ".", "Telescope lsp_code_actions")
ncmd(prefix .. "r", "Telescope lsp_references")

-- vim options
ncmd(prefix .. "o", "Telescope vim_options")

-- mappings in telescope interface
local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
local mappings = {
  i = {
    ["?"] = actions_layout.toggle_preview,
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
  },
  pickers = { hidden = true },
}

-- 〉

-- Extensions 〈
local function load(name)
  require("telescope").load_extension(name)
end

load("fzf")

load("coc")
ncmd(prefix .. "cc", "Telescope coc commands")
ncmd(prefix .. "ca", "Telescope coc file_code_actions")
ncmd(prefix .. "cA", "Telescope coc code_actions")
ncmd(prefix .. "cs", "Telescope coc document_symbols")
ncmd(prefix .. "cS", "Telescope coc workspace_symbols")

load("aerial")
ncmd(prefix .. "a", "Telescope aerial")

load("ui-select")

load("packer")
map(prefix .. "p", [[extensions.packer.packer(opts) ]])

load("file_browser")
map("<M-/>t", [[extensions.file_browser.file_browser() ]])

load("notify")
ncmd(prefix .. "n", "Telescope notify")

-- telescope-rg (telescope-live-grep-raw)
map(prefix .. "R", "extensions.live_grep_raw.live_grep_raw()")

load("dap")
ncmd(prefix .. "d:", "Telescope dap commands")
ncmd(prefix .. "dc", "Telescope dap configurations")
ncmd(prefix .. "dv", "Telescope dap variables")
ncmd(prefix .. "df", "Telescope dap frames")
ncmd(prefix .. "db", "Telescope dap list_breakpoints")

load("termfinder")
ncmd(prefix .. "/", "Telescope termfinder find")
-- 〉
