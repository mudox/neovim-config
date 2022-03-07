-- vim: fdm=marker fmr=\ 〈,\ 〉

-- Mappings 〈
local k = require("mudox.keymap")
local ncmd = k.ncmd

local prefix = ",t"

-- builtin
---@diagnostic disable-next-line: lowercase-global
function _mdx_telescope_picker_builtin()
  local opts = {
    include_extensions = true,
  }
  require("telescope.builtin").builtin(opts)
end
ncmd(prefix .. ",", "lua _mdx_telescope_picker_builtin()")

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
ncmd(prefix .. "d", "Telescope diagnostics bufnr=0")

-- lsp
ncmd(prefix .. ".", "Telescope lsp_code_actions")
ncmd(prefix .. "r", "Telescope lsp_references")

-- vim options
ncmd(prefix .. "o", "Telescope vim_options")

-- mappings in telescope interface
local actions = require("telescope.actions")
local mappings = {
  i = {},
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
    -- preview = {
    -- hide_on_startup = true,
    -- },
  },

  extensions = {
    -- packer = {
    -- theme = "ivy",
    -- layout_config = {
    -- height = 0.5,
    -- },
    -- },

    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      },
    },
  },
  pickers = { hidden = true },
}

-- 〉

-- Extensions 〈
require("telescope").load_extension("fzf")

require("telescope").load_extension("coc")
ncmd(prefix .. "cc", "Telescope coc commands")
ncmd(prefix .. "ca", "Telescope coc file_code_actions")
ncmd(prefix .. "cA", "Telescope coc code_actions")
ncmd(prefix .. "cs", "Telescope coc document_symbols")
ncmd(prefix .. "cS", "Telescope coc workspace_symbols")

require("telescope").load_extension("aerial")
ncmd(prefix .. "a", "Telescope aerial")

require("telescope").load_extension("ui-select")

require("telescope").load_extension("packer")
ncmd(prefix .. "p", [[ lua require('telescope').extensions.packer.packer(opts) ]])

require("telescope").load_extension("file_browser")
ncmd("<M-/>t", [[ lua require 'telescope'.extensions.file_browser.file_browser() ]])

require("telescope").load_extension("notify")
ncmd(prefix .. "n", "Telescope notify")

-- telescope-rg
ncmd(prefix .. "R", [[ lua require("telescope").extensions.live_grep_raw.live_grep_raw() ]])
-- 〉
