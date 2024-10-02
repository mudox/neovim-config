local function init()
  vim.g.VM_mouse_mappings = 1
  vim.g.VM_leader = "<leader>m"
  vim.g.VM_maps = {
    ["Reselect Last"] = "<leader>m.",
  }
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
  -- cond = false, -- conflicts with multicursor.nvim
}
