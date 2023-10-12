local dependencies = {
  "nvim-dap-ui",

  -- adapters
  -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
  "jbyuki/one-small-step-for-vimkind", -- Neovim lua
}

-- Neovim lua
local function neovim_lua()
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

local function c()
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

local function python() end

local function javascript() end

local function rust() end

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
  c()
  javascript()
  neovim_lua()
  python()
  rust()

  setup_ui()
end

local function r()
  return require("dap")
end

-- stylua: ignore start
local keys = {
  {"<F5>",  function() r().continue() end,                                                    "Continue"},
  {"<F10>", function() r().step_over() end,                                                   "Step over"},
  {"<F11>", function() r().step_into() end,                                                   "Step into"},
  {"<F12>", function() r().step_out() end,                                                    "Step out"},
  {".",     function() r().run_last() end,                                                    "Re-debug"},
  {"r",     function() r().run_last() end,                                                    "Re-debug"},

  {"b",     function() r().toggle_breakpoint() end,                                           "Toggle breakpoint"},
  {"B",     function() r().set_breakpoint() end,                                              "Set breakpoint"},
  {"p",     function() r().set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, "Set log point"},

  {":",     function() r().repl.open() end,                                                   "Open repl"},
}
-- stylua: ignore

keys = require("mudox.util.keymap").lazy_keys(keys, {
  key_prefix = '<leader>d',
  desc_prefix = 'Dap',
})

return {
  "mfussenegger/nvim-dap",
  dependencies = dependencies,
  keys = keys,
  config = config,
}
