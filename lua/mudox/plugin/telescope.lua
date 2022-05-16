url = "nvim-telescope/telescope.nvim"

requires = {
  { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "nvim-telescope/telescope-packer.nvim" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-rg.nvim" },
  { "nvim-telescope/telescope-dap.nvim" },
  { "crispgm/telescope-heading.nvim" },
}

event = "UIEnter"

for i = 1, #requires do
  local spec = requires[i]
  spec.event = event
  spec.after = "telescope.nvim"
end

after = { "trouble.nvim" }
