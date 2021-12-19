vim.o.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")

local snippet = {
	expand = function(args)
		vim.fn["UltiSnips#Anon"](args.body)
	end,
}

local mapping = {
	["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
	["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
	["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
	["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
	["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
	-- Accept currently selected item. If none selected, `select` first item.
	-- Set `select` to `false` to only confirm explicitly selected items.
	["<CR>"] = cmp.mapping.confirm({ select = true }),
}

local sources = {
	{ name = "cmp-nvim-lsp" },
	{ name = "cmp-buffer" },
	{ name = "cmp-path" },
	{ name = "cmp-cmdline" },
	{ name = "cmp-ultisnips" },
}

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { "rust_analyzer", "vimls", "pyright", "html", "sumneko_lua" }
for _, server in ipairs(servers) do
	require("lspconfig")[server].setup({ capabilities = capabilities })
end

cmp.setup({
	snippet = snippet,
	mapping = mapping,
	sources = sources,
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})
