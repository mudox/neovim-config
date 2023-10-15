local opts = {
  floating = {
    border = require("mudox.ui.icons").border.corner,
  },
}

return {
  "rcarriga/nvim-dap-ui",
  dependencies = "nvim-dap",
  opts = opts,
}
