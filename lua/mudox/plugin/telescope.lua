url = "nvim-telescope/telescope.nvim"

requires = {
  { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "nvim-telescope/telescope-packer.nvim" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "crispgm/telescope-heading.nvim" },
}

if mode == "lsp" then
  requires[#requires + 1] = { "nvim-telescope/telescope-dap.nvim" }
end

event = "UIEnter"

after = {
  "trouble.nvim",
  "telescope-fzf-native.nvim",
  "telescope-live-grep-args.nvim",
  "telescope-ui-select.nvim",
  "telescope-packer.nvim",
  "telescope-file-browser.nvim",
  "telescope-heading.nvim",
  "nvim-neoclip.lua",
}
