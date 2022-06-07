url = "nvim-telescope/telescope.nvim"

requires = {
  { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "nvim-telescope/telescope-packer.nvim" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  { "nvim-telescope/telescope-dap.nvim" },
  { "crispgm/telescope-heading.nvim" },

  -- ISSUE: curent not working with firefox
  -- track: https://github.com/dhruvmanila/telescope-bookmarks.nvim/issues/5
  -- track: https://github.com/tami5/sqlite.lua/pull/132
  { "dhruvmanila/telescope-bookmarks.nvim", requires = "tami5/sqlite.lua" },
}

event = "UIEnter"

for i = 1, #requires do
  local spec = requires[i]
  spec.event = event
  spec.after = "telescope.nvim"
end

after = { "trouble.nvim" }
