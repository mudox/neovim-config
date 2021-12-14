url = "nvim-telescope/telescope.nvim"

requires = {
	{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
	{ "fannheyward/telescope-coc.nvim" }, -- remove it?
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{ "nvim-telescope/telescope-packer.nvim" },
}

after = { "plenary.nvim", "popup.nvim", "telescope-fzf-native.nvim", "telescope-ui-select.nvim" }

event = "VimEnter"
