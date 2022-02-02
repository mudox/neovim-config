-- vim: fdm=marker fmr=\ 〈,\ 〉

-- Mappings 〈
local k = require("keymap")
local ncmd = k.ncmd

local prefix = ",t"

-- builtin
---@diagnostic disable-next-line: lowercase-global
function _mdx_telescope_picker_builtin()
  local theme = require('telescope.themes').get_dropdown
  local opts = theme({
		include_extensions = true,
  })
	require("telescope.builtin").builtin(opts)
end
ncmd(prefix .. ",", "lua _mdx_telescope_picker_builtin()")

-- files
ncmd("<C-p>", "Telescope find_files")

-- recent files
ncmd("<Space>r", "Telescope oldfiles")

ncmd(prefix .. "f", "Telescope git_files")

ncmd(prefix .. "/", "Telescope file_browser")

-- grep string under cursor
ncmd(prefix .. "g", "Telescope grep_string")
ncmd(prefix .. "G", "Telescope live_grep")

ncmd(prefix .. "s", "Telescope treesitter")

-- diagnostics
ncmd(prefix .. "d", "Telescope diagnostics bufnr=0")

-- lsp code actions
ncmd(prefix .. ".", "Telescope lsp_code_actions")

-- vim options
ncmd(prefix .. "o", "Telescope vim_options")
-- 〉

-- Setup 〈

require("telescope").setup({
	defaults = {
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		-- borderchars = {'─', '│', '─', '│', '┌', '┐', '┘', '└'},

    -- mappings = {
      -- ['<C-e>'] = require('telescope.actions.layout').toggle_preview,
    -- },

    -- preview = {
      -- hide_on_startup = true,
    -- },

		-- extensions
		extensions = {
			-- packer = {
				-- theme = "ivy",
				-- layout_config = {
					-- height = 0.5,
				-- },
			-- },

			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = false, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},

			["ui-select"] = {
				require("telescope.themes").get_dropdown({
					-- even more opts
				}),
			},
		},
	},
	pickers = { hidden = true },
})

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
-- 〉
