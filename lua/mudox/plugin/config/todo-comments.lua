-- see https://github.com/folke/todo-comments.nvim#%EF%B8%8F-configuration
local opts = {
	keywords = {
		FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
		TODO = { icon = " ", color = "info", alt = { "LATER" } },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
		PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
	},
}

require("todo-comments").setup(opts)

local ncmd = require("mudox/keymap").ncmd

ncmd(",xt", "TodoTrouble")
ncmd(",tt", "TodoTelescope")
