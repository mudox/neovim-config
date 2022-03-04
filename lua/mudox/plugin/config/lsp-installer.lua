local installer = require("nvim-lsp-installer")
local handler = require("mudox.lsp.handler")

handler.setup()

installer.on_server_ready(function(server)
	local opts = {
		on_attach = handler.on_attach,
		capabilities = handler.capabilities,
	}

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("mudox.lsp.server.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server.name == "jsonls" then
		local jsonls_opts = require("mudox.lsp.server.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	server:setup(opts)
end)
