local function init()
  vim.g.VM_leader = "<M-Bslash>"
end

local config = function()
  vim.cmd.VMTheme("neon")

  vim.api.nvim_create_autocmd("User", {
    pattern = "visual_multi_start",
    callback = function()
      require("lualine").hide()
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "visual_multi_exit",
    callback = function()
      require("lualine").hide { unhide = true }
    end,
  })
end

return {
  "mg979/vim-visual-multi",
  event = "BufEnter",
  init = init,
  config = config,
}
