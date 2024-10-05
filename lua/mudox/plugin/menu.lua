local function right_mouse()
  -- vim.cmd.exec('"normal! \\<RightMouse>"')

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end

return {
  "nvchad/menu",
  dependencies = "nvchad/volt",
  -- stylua: ignore
  keys = {
    -- TODO: customize menus
    { "<C-t>", function() require("menu").open("default") end, desc = "[Menu] Default" },
    { "<RightMouse>", right_mouse, desc = "[Menu] Right mouse" },
  },
}
