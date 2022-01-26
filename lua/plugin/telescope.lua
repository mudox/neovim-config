url = "nvim-telescope/telescope.nvim"

requires = {
	{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
	{ "fannheyward/telescope-coc.nvim" },
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "nvim-telescope/telescope-packer.nvim" },
	{ "nvim-telescope/telescope-file-browser.nvim" },
}

event = "VimEnter"
