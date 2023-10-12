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
  local function lang(name)
    require("mudox.plugin.dap.lang." .. name)()
  end

  lang("neovim_lua")

  setup_ui()
end

local function r()
  return require("dap")
end

local function w()
  return require("dap.ui.widgets")
end

local function set_log_point()
  r().set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end

-- stylua: ignore
local keys = {
  -- session
  { "<F5>",  function() r().continue() end,                           "Continue"            },
  { ".",     function() r().run_last() end,                           "Run last"            },
  { "r",     function() r().restart() end,                            "Restart"             },
  { "q",     function() r().terminate() end,                          "Quit"                },

  -- stepping
  { "<F10>", function() r().step_over() end,                          "Step over"           },
  { "<F11>", function() r().step_into() end,                          "Step into"           },
  { "<F12>", function() r().step_out() end,                           "Step out"            },
  { "U",     function() r().step_back() end,                          "Step back"           },
  { "g",     function() r().run_to_cursor() end,                      "Run to cursor"       },

  -- thread
  { "P",     function() r().pause() end,                              "Pause thread"        },
  { "k",     function() r().step_back() end,                          "Up stacktrace"       },
  { "j",     function() r().step_back() end,                          "Down stacktrace"     },

  -- breakpoint
  { "<F4>",  function() r().toggle_breakpoint() end,                  "Toggle breakpoint"   },
  { "b",     function() r().toggle_breakpoint() end,                  "Toggle breakpoint"   },
  { "B",     function() r().set_breakpoint() end,                     "Set breakpoint"      },
  { "p",     set_log_point,                                           "Set log point"       },
  { "x",     function() r().set_exception_breakpoints("default") end, "Break on exceptions" },
  { "l",     function() r().list_breakpoints() end,                   "List breakpoints"    },
  { "C",     function() r().clear_breakpoints() end,                  "Clear breakpoints"   },

  -- repl
  { ":",     function() r().repl.toggle() end,                        "Toggle repl"         },

  -- widgets
  { "k",     function() w().hover() end,                              "Hover"               },
  { "p",     function() w().preview() end,                            "Preview"             },
  { "s",     function() w().centered_float(w().scopes) end,           "Popup scopes"        },
}

keys = require("mudox.util.keymap").lazy_keys(keys, {
  key_prefix = "<leader>d",
  desc_prefix = "Dap",
})

return {
  "mfussenegger/nvim-dap",
  keys = keys,
  config = config,
}
