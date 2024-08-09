local function title(name)
  -- stylua: ignore
  return name
    :gsub("^nvim[-_]", "")
    :gsub("%.lua$", "")
    :gsub("[.-_]nvim$", "")
    :gsub("_", "-")
end

-- action to open selected plugin in separate tmux window
local function open_plugin_window(prompt_buf)
  local state = require("telescope.actions.state")
  local entry = state.get_selected_entry()

  local name = entry.value.name
  local path = entry.value.path

  require("telescope.actions").close(prompt_buf)
  vim.print(vim.system {
    vim.env.MDX_NVIM_DIR .. "/scripts/tmux_plugin_win.sh",
    name,
    path,
  })
end

return {
  "tsakirist/telescope-lazy.nvim",
  dependencies = "telescope.nvim",
  keys = { { "<leader>tp", "<Cmd>Telescope lazy<Cr>", desc = "Plugins" } },
  config = function()
    require("telescope._extensions.lazy.actions").open_in_terminal = open_plugin_window
    local t = require("telescope")
    t.load_extension("lazy")
  end,
}
