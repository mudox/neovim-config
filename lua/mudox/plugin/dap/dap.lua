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

local function open_dap_tabpage()
  local varname = "mdx_is_dap_tabpage"

  -- create new one
  vim.cmd.tabedit("%")
  vim.api.nvim_tabpage_set_var(0, varname, true)
  local id = vim.api.nvim_get_current_tabpage()

  -- close all old dap tabpages if any
  for _, v in ipairs(vim.api.nvim_list_tabpages()) do
    if v ~= id and pcall(vim.api.nvim_tabpage_get_var, v, varname) then
      vim.api.nvim_set_current_tabpage(v)
      vim.cmd.tabclose()
    end
  end

  return vim.api.nvim_get_current_tabpage()
end

local function setup_listeners()
  local dap = require("dap")
  local ui = require("dapui")

  dap.listeners.after.event_initialized["mudox"] = function()
    print("DAP started")
    open_dap_tabpage()
    ui.open()
  end

  dap.listeners.before.event_terminated["mudox"] = function()
    print("DAP will terminate")
    -- ui.close()
  end

  dap.listeners.before.event_exited["mudox"] = function()
    print("DAP will exit")
    -- ui.close()
  end
end

local function config()
  setup_sings()
  setup_listeners()

  -- language setups
  local function lang(name)
    require("mudox.plugin.dap.lang." .. name)()
  end

  lang("neovim_lua")
  -- lang("python")
  -- lang("rust")
  -- lang("javascript")
  -- lang("c")
end

return {
  "mfussenegger/nvim-dap",
  dependencies = { "nvim-dap-ui", "nvim-dap-virtual-text" },
  keys = require("mudox.plugin.dap.keymaps"),
  config = config,
}
