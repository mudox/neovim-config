url = "christoomey/vim-tmux-navigator"

event = "VimEnter"

function config()
  -- vim.g.tmux_navigator_preserve_zoom = 1
  vim.g.tmux_navigator_disable_when_zoomed = 1
end
