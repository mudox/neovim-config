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

local function setup_listeners()
  local dap = require("dap")
  local ui = require("dapui")

  dap.listeners.after.event_initialized["mudox"] = function()
    print("DAP started")
    -- IDEA: % may not be a valid source file
    X.tabman.open("Dap", "tabedit %")
    ui.open { reset = true }
  end

  dap.listeners.before.event_terminated["mudox"] = function()
    print("DAP terminated")
  end

  dap.listeners.before.event_exited["mudox"] = function()
    print("DAP exited")
  end
end

local function config()
  -- patch nvim-dap
  require("overseer") -- let lazy to setup overseer if not
  -- support launchjs.json written in JSON5
  require("dap.ext.vscode").json_decode = require("overseer.json").decode

  setup_sings()
  setup_listeners()

  -- language setups
  local function setup(name)
    require("mudox.plugin.debug.lang." .. name).setup()
  end

  setup("neovim_lua")
  setup("javascript") -- as well as typescript ...
  -- setup("rust")
  -- setup("python")
  -- setup("c")
end

return {
  "mfussenegger/nvim-dap",
  dependencies = { "nvim-dap-ui", "nvim-dap-virtual-text" },
  keys = require("mudox.plugin.debug.keymaps"),
  config = config,
}
