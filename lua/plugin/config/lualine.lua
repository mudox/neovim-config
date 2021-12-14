vim.o.laststatus = 2

require("lualine").setup({
	options = {
		icons_enabled = true,

		-- themes
		-- theme = 'gruvbox',
		-- theme = 'auto',
		theme = "ayu_mirage",

		-- separators
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		-- section_separators = {left = '', right = ''},
		-- component_separators = {left = '', right = ''},

		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_c = { "filename" },
		lualine_x = { "diagnostics", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	tabline = {
		lualine_a = { "buffers" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = { [[ vim.g.mdx_nvim_mode .. ' ' ]] },
		lualine_z = { "tabs" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	extensions = {},
})
