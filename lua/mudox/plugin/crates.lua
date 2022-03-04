url = "saecki/crates.nvim"
tag = "v0.1.0"

event = { "BufRead Cargo.toml" }

requires = "nvim-lua/plenary.nvim"

config = function()
	require("crates").setup()

	vim.cmd([[ autocmd FileType toml lua require('cmp').setup.buffer { sources = { { name = 'crates' } } } ]])
end
