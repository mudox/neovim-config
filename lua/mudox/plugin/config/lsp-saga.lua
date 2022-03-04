-- vim: fdm=marker fmr=〈,〉

-- Settings 〈
local opts = { -- defaults ...
	-- debug = false,
	-- use_saga_diagnostic_sign = true,
	-- -- diagnostic sign
	-- error_sign = "",
	-- warn_sign = "",
	-- hint_sign = "",
	-- infor_sign = "",
	-- diagnostic_header_icon = "   ",
	-- -- code action title icon
	-- code_action_icon = " ",
	-- code_action_prompt = {
	-- enable = true,
	-- sign = true,
	-- sign_priority = 40,
	-- virtual_text = true,
	-- },
	-- finder_definition_icon = "  ",
	-- finder_reference_icon = "  ",
	-- max_preview_lines = 10,
	-- finder_action_keys = {
	-- open = "o",
	-- vsplit = "s",
	-- split = "i",
	-- quit = "q",
	-- scroll_down = "<C-f>",
	-- scroll_up = "<C-b>",
	-- },
	-- code_action_keys = {
	-- quit = "q",
	-- exec = "<CR>",
	-- },
	-- rename_action_keys = {
	-- quit = "<C-c>",
	-- exec = "<CR>",
	-- },
	-- definition_preview_icon = "  ",
	-- border_style = "single",
	-- rename_prompt_prefix = "➤",
	-- server_filetype_map = {},
	-- diagnostic_prefix_format = "%d. ",
}

require("lspsaga").setup(opts)

-- 〉

-- Mappings 〈

local ncmd = require("mudox.keymap").ncmd
local xcmd = require("mudox.keymap").xcmd

-- refactor
ncmd(",rn", "Lspsaga rename")

-- code action
ncmd("gx", "Lspsaga code_action")
xcmd("gx", "Lspsaga range_code_action")

-- help
ncmd("gh", "Lspsaga hover_doc")
ncmd("gs", "Lspsaga signature_help")
ncmd("gd", "Lspsaga preview_definition")

-- diagnostics
ncmd("gc", "Lspsaga show_cursor_diagnostics")
ncmd("gl", "Lspsaga show_line_diagnostics")

-- navigation
ncmd("]g", "Lspsaga diagnostic_jump_next")
ncmd("[g", "Lspsaga diagnostic_jump_prev")
ncmd("gr", "Lspsaga lsp_finder")

-- scroll page
ncmd("<C-f>", "lua require('lspsaga.action').smart_scroll_with_saga(1)")
ncmd("<C-b>", "lua require('lspsaga.action').smart_scroll_with_saga(-1)")

-- 〉
