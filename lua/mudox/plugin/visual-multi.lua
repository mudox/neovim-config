local function init()
  vim.g.VM_leader = "<M-Bslash>"
end

local config = function()
  vim.cmd.VMTheme("neon")

  U.on("User", {
    pattern = "visual_multi_start",
    callback = function()
      require("lualine").hide()
    end,
  })

  U.on("User", {
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
