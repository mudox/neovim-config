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
  { "<F5>",    function() d().continue() end,                           "[DAP] Continue"              ,l = false, },
  { ".",       function() d().run_last() end,                           "[DAP] Run last"                          },
  { "r",       function() d().restart() end,                            "[DAP] Restart"                           },
  { "q",       function() d().terminate() end,                          "[DAP] Quit"                              },

  -- stepping
  { "<F10>",   function() d().step_over() end,                          "[DAP] Step over"             ,l = false, },
  { "<F11>",   function() d().step_into() end,                          "[DAP] Step into"             ,l = false, },
  { "<F12>",   function() d().step_out() end,                           "[DAP] Step out"              ,l = false, },
  { "U",       function() d().step_back() end,                          "[DAP] Step back"             ,l = false, },
  { "g",       function() d().run_to_cursor() end,                      "[DAP] Run to cursor"                     },

  -- thread
  { "P",       function() d().pause() end,                              "[DAP] Pause thread"                      },
  { "k",       function() d().step_back() end,                          "[DAP] Up stacktrace"                     },
  { "j",       function() d().step_back() end,                          "[DAP] Down stacktrace"                   },

  -- breakpoint
  { "<F4>",    function() d().toggle_breakpoint() end,                  "[DAP] Toggle breakpoint"     ,l = false, },
  { "b",       function() d().toggle_breakpoint() end,                  "[DAP] Toggle breakpoint"                 },
  { "B",       function() d().set_breakpoint() end,                     "[DAP] Set breakpoint"                    },
  { "p",       set_log_point,                                           "[DAP] Set log point"                     },
  { "x",       function() d().set_exception_breakpoints("default") end, "[DAP] Break on exceptions"               },
  { "l",       function() d().list_breakpoints() end,                   "[DAP] List breakpoints"                  },
  { "C",       function() d().clear_breakpoints() end,                  "[DAP] Clear breakpoints"                 },

  -- repl
  { ":",       function() d().repl.toggle() end,                        "[DAP] Toggle repl"                       }, -- dapui already have repl element?

  -- widgets
  { "k",       function() w().hover() end,                              "[DAP] Hover"                             }, -- use dapui.eval() (<leader>d=) instead?
  { "p",       function() w().preview() end,                            "[DAP] Preview"                           },

  -- ui
  { "<Space>", function() u().toggle {} end,                            "[DAPUI] Toggle panels"                   },

  { "0",       float("stacks"),                                         "[DAPUI] Frames (popup)"                  },
  { "9",       float("watches"),                                        "[DAPUI] Watcher (popup)"                 },
  { "8",       float("breakpoints"),                                    "[DAPUI] Breakpoints (popup)"             },
  { "7",       float("scopes"),                                         "[DAPUI] Variables (popup)"               },

  { "=",       function() u().eval() end,                               "[DAPUI] Eval"                            },
}

keys = require("mudox.util.keymap").lazy_keys(keys, {
  key_prefix = "<leader>d",
})

return keys
