local opts = {
  floating = {
    border = require("mudox.ui.icon").border.corner,
  },
}

return {
  "rcarriga/nvim-dap-ui",
  dependencies = "nvim-dap",
  opts = opts,
}
