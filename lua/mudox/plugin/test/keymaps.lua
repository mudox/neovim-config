-- stylua: ignore
local function m() return require("neotest") end

-- test / debug
-- stylua: ignore start
local function test_suite()            m().run.run({ suite = true })                         end
local function test_nearest()          m().run.run()                                         end
local function debug_nearest()         m().run.run({ strategy = "dap" })                     end
local function test_file()             m().run.run(vim.fn.expand("%"))                       end
local function debug_file()            m().run.run({ vim.fn.expand("%"), strategy = "dap" }) end
local function test_last()             m().run.run_last()                                    end
local function debug_last()            m().run.run_last({ strategy = "dap" })                end

-- stop
local function stop_nearest()          m().run.stop()                                        end
local function attach_to_nearest()     m().run.attach()                                      end

-- ui
local function toggle_summary()        m().summary.toggle()                                  end
local function open_output_float()     m().output.open()                                     end
local function toggle_output_panel()   m().output_panel.toggle()                             end

-- watch
local function toggle_watch_file()     m().watch.toggle(vim.fn.expand("%"))                  end

-- jump
local function goto_next_test()        m().jump.next()                                       end
local function goto_prev_test()        m().jump.prev()                                       end
local function goto_next_failed_test() m().jump.next({ status = "failed" })                  end
local function goto_prev_failed_test() m().jump.prev({ status = "failed" })                  end
-- stylua: ignore end

local test_nav = {
  name = "test",
  next = goto_next_test,
  prev = goto_prev_test,
}
local failed_test_nav = {
  name = "failed test",
  next = goto_next_failed_test,
  prev = goto_prev_failed_test,
}

-- stylua: ignore
local keys = {
  -- test
  { ".",       test_last,             "Test last",                      },
  { "<Cr>",    test_nearest,          "Test nearest",                   },
  { "c",       test_nearest,          "Test nearest",                   },
  { "f",       test_file,             "Test file",                      },
  { "s",       test_suite,            "Test suite",                     },

  -- debug
  { ",",       debug_last,            "Debug last",                     },
  { "d",       debug_nearest,         "Debug nearest",                  },
  { "F",       debug_file,            "Debug file",                     },
  { "a",       attach_to_nearest,     "Attach to nearest",              },

  -- stop
  { "<Bs>",    stop_nearest,          "Stop nearest",                   },

  -- watch
  { "w",       toggle_watch_file,     "Toggle watch file",              },

  -- ui
  { "<Space>", toggle_summary,        "Toggle summary",                 },
  { "v",       open_output_float,     "Show output float",              },
  { "l",       toggle_output_panel,   "Toggle output panel",            },

  -- jump
  { "]t",      X.dirop.wrap(test_nav, "next"),        "Next test",            k =  "l", },
  { "[t",      X.dirop.wrap(test_nav, "prev"),        "Previous test",        k =  "l", },
  { "]T",      X.dirop.wrap(failed_test_nav, "next"), "Next failed test",     k =  "l", },
  { "[T",      X.dirop.wrap(failed_test_nav, "prev"), "Previous failed test", k =  "l", },
}
keys = K.lazy_keys(keys, {
  key_prefix = "<leader>c",
  desc_prefix = "Neotest",
})

return keys
