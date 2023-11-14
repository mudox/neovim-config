-- DAP

local function d()
  return require("dap")
end

local function w()
  return require("dap.ui.widgets")
end

local function u()
  return require("dapui")
end

local function set_log_point()
  d().set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end

local function float(name)
  return function()
    u().float_element(name, {
      enter = true,
      width = 60,
      height = 16,
    })
  end
end

-- stylua: ignore
local keys = {
  -- session
  { "<F5>",    function() d().continue() end,                           "Continue",                    k =  "l", },
  { ".",       function() d().run_last() end,                           "Run last",                              },
  { "r",       function() d().restart() end,                            "Restart",                               },
  { "q",       function() d().terminate() end,                          "Quit",                                  },

  -- stepping
  { "<F10>",   function() d().step_over() end,                          "Step over",                   k =  "l", },
  { "<F11>",   function() d().step_into() end,                          "Step into",                   k =  "l", },
  { "<F12>",   function() d().step_out() end,                           "Step out",                    k =  "l", },
  { "U",       function() d().step_back() end,                          "Step back",                   k =  "l", },
  { "g",       function() d().run_to_cursor() end,                      "Run to cursor",                         },

  -- thread
  { "P",       function() d().pause() end,                              "Pause thread",                          },
  { "k",       function() d().step_back() end,                          "Up stacktrace",                         },
  { "j",       function() d().step_back() end,                          "Down stacktrace",                       },

  -- breakpoint
  { "<F4>",    function() d().toggle_breakpoint() end,                  "Toggle breakpoint",           k =  "l", },
  { "b",       function() d().toggle_breakpoint() end,                  "Toggle breakpoint",                     },
  { "B",       function() d().set_breakpoint() end,                     "Set breakpoint",                        },
  { "p",       set_log_point,                                           "Set log point",                         },
  { "x",       function() d().set_exception_breakpoints("default") end, "Break on exceptions",                   },
  { "l",       function() d().list_breakpoints() end,                   "List breakpoints",                      },
  { "C",       function() d().clear_breakpoints() end,                  "Clear breakpoints",                     },

  -- repl
  -- dapui already have repl element?
  { ":",       function() d().repl.toggle() end,                        "Toggle repl",                           },

  -- widgets
  -- use dapui.eval() (<leader>d=) instead?
  { "k",       function() w().hover() end,                              "Hover",                                 },
  { "p",       function() w().preview() end,                            "Preview",                               },

  -- ui
  { "<Space>", function() u().toggle() end,                            "[DAPUI] Toggle panels",                  },

  { "0",       float("stacks"),                                         "[DAPUI] Frames (popup)",                },
  { "9",       float("watches"),                                        "[DAPUI] Watcher (popup)",               },
  { "8",       float("breakpoints"),                                    "[DAPUI] Breakpoints (popup)",           },
  { "7",       float("scopes"),                                         "[DAPUI] Variables (popup)",             },

  { "=",       function() u().eval() end,                               "[DAPUI] Eval",                          },
}

keys = K.lazy_keys(keys, {
  key_prefix = "<leader>d",
  desc_prefix = "DAP",
})

return keys
