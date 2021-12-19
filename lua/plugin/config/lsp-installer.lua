local lsp_installer = require("nvim-lsp-installer")

-- Include the servers you want to have installed by default below
-- local servers = { "pyright", "rust-analyzer", "sumneko_lua", "html", "vimls" }
-- for _, name in pairs(servers) do
-- local server_is_found, server = lsp_installer.get_server(name)
-- if server_is_found then
-- if not server:is_installed() then
-- print("Installing " .. name)
-- server:install()
-- end
-- end
-- end

lsp_installer.on_server_ready(function(server)
	local opts = {}

	if server.name == "sumneko_lua" then
		local runtime_path = vim.split(package.path, ";")
		table.insert(runtime_path, "lua/?.lua")
		table.insert(runtime_path, "lua/?/init.lua")

		opts.settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = runtime_path,
				},
				diagnostics = {
					globals = { "vim", "pl", "stdpath" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		}
	end

	server:setup(opts)
end)
