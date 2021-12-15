url = "luukvbaal/stabilize.nvim"

function config()
	require("stabilize").setup({
		-- stabilize window even when current cursor position will be hidden behind new window
		force = false, -- `true` cause CocList to lose input field
		-- set context mark to register on force event which can be jumped to with '<forcemark>
		forcemark = nil,
		-- do not manage windows matching these file/buftypes
		ignore = {
			filetype = { "help", "list", "Trouble" },
			buftype = { "terminal", "quickfix", "loclist" },
		},
		-- comma-separated list of autocmds that wil trigger the plugins window restore function
		nested = "QuickFixCmdPost,DiagnosticChanged *",
	})
end
