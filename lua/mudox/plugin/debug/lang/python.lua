-- local function setup() end

local adapter = {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  config = function()
    local p = require("dap-python")

    p.setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
    p.test_runner = "pytest"

    -- stylua: ignore
    require('which-key').register({
      ["<leader>cm"] = { function() require("dap-python").test_method() end, "[DAP Python] Test method" },
      ["<leader>ck"] = { function() require("dap-python").test_class()  end,  "[DAP Python] Test class" },
    }, { buffer = vim.api.nvim_get_current_buf() })
  end,
}

return {
  adapter = adapter,
}
