local function setup() end

local adapter = {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  -- stylua: ignore
  keys = {
    { "<leader>cm", function() require("dap-python").test_method() end, desc = "[DAP Python] Test method", },
    { "<leader>cc", function() require("dap-python").test_class()  end, desc = "[DAP Python] Test class", },
  },
  config = function()
    local p = require("dap-python")

    p.setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
    p.test_runner = "pytest"
  end,
}

return {
  adapter = adapter,
}
