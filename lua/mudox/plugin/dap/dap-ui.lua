local opts = {
  expand_lines = true,
  icons = { expanded = "", collapsed = "", circular = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.33 },
        { id = "breakpoints", size = 0.17 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 0.33,
      position = "right",
    },
    {
      elements = {
        { id = "repl", size = 0.45 },
        { id = "console", size = 0.55 },
      },
      size = 0.27,
      position = "bottom",
    },
  },
  floating = {
    max_height = 0.8,
    max_width = 0.6,
    border = require("mudox.ui.icons").border.corner,
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
}

local function setup_sings()
  -- stylua: ignore
  local signs = {
    { "DapBreakpoint",          " " },
    { "DapBreakpointCondition", " " },
    { "DapLogPoint",            " " },
    { "DapStopped",             " " },
    { "DapBreakPointRejected",  " " },
  }

  for _, v in ipairs(signs) do
    vim.fn.sign_define(v[1], { text = v[2] })
  end
end

local function config()
  require("dapui").setup(opts)

  setup_sings()
end

-- stylua: ignore
local keys = {
  { "<leader>dv", function() require("dapui").toggle({ }) end, desc = "[Dap] Toggle UI" },
  { "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "[Dap] Eval" },
}

return {
  "rcarriga/nvim-dap-ui",
  dependencies = "nvim-dap",
  keys = keys,
  config = config,
}
