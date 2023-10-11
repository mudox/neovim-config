local dependencies = {
  "nvim-dap-ui",

  -- adapters
  -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
  "jbyuki/one-small-step-for-vimkind", -- Neovim lua
}

local keys = {}

-- Neovim lua
local function neovim_lua_debugging()
  local dap = require("dap")

  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
    },
  }

  dap.adapters.nlua = function(callback, cfg)
    callback { type = "server", host = cfg.host or "127.0.0.1", port = cfg.port or 8086 }
  end
end

local function c_debugging()
  local dap = require("dap")

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      -- provide the absolute path for `codelldb` command if not using the one installed using `mason.nvim`
      command = "codelldb",
      args = { "--port", "${port}" },
      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }
  dap.configurations.c = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        local path
        vim.ui.input({ prompt = "Path to executable: ", default = vim.loop.cwd() .. "/build/" }, function(input)
          path = input
        end)
        vim.cmd([[redraw]])
        return path
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
end

local function python_debugging() end

local function javascript_debugging() end

local function rust_debugging() end

local function setup_ui()
  local dap = require("dap")

  dap.listeners.after.event_initialized["dapui_config"] = function()
    require("dapui").open()
  end

  dap.listeners.before.event_terminated["dapui_config"] = function()
    require("dapui").close()
  end

  dap.listeners.before.event_exited["dapui_config"] = function()
    require("dapui").close()
  end
end

local function config()
  c_debugging()
  javascript_debugging()
  neovim_lua_debugging()
  python_debugging()
  rust_debugging()

  setup_ui()
end

return {
  "mfussenegger/nvim-dap",
  dependencies = dependencies,
  keys = keys,
  config = config,
}
