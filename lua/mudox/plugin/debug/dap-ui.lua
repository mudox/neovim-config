local function opts()
  local i = require("mudox.ui.icon")
  return {
    floating = {
      border = i.border.corner,
      icons = {
        collapsed = i.chevron.right,
        expanded = i.chevron.down,
      },
      render = {
        max_value_lines = 60,
      },
    },
  }
end

return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "nvim-dap", "nvim-neotest/nvim-nio" },
  opts = opts,
}
