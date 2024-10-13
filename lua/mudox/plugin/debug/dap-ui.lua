local function opts()
  return {
    floating = {
      border = I.border.corner,
      icons = {
        collapsed = I.chevron.right,
        expanded = I.chevron.down,
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
