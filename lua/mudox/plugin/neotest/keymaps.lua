local function m()
  return require("neotest")
end

-- test / debug
-- stylua: ignore start
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
local function open_summary()          m().summary.open()                                    end
local function open_output()           m().output.open()                                     end
local function open_output_panel()     m().output_panel.toggle()                             end

-- watch
local function watch_file()            m().watch.toggle(vim.fn.expand("%"))                  end

-- jump
local function goto_next_test()        m().jump.next()                                       end
local function goto_prev_test()        m().jump.prev()                                       end

local function goto_next_failed_test() m().jump.next({ status = "failed" })                  end
local function goto_prev_failed_test() m().jump.prev({ status = "failed" })                  end
-- stylua: ignore end

-- stylua: ignore
local keys = {
  -- test
  { "<Cr>",    test_nearest,          "Test nearest",                   },
  { "c",       test_file,             "Test file",                      },
  { ".",       test_last,             "Test last",                      },

  -- debug
  { "d",       debug_nearest,         "Debug nearest",                  },
  { "D",       debug_file,            "Debug file",                     },
  { ">",       debug_last,            "Debug last",                     },
  { "a",       attach_to_nearest,     "Attach to nearest",              },

  -- stop
  { "<Bs>",    stop_nearest,          "Stop nearest",                   },

  -- watch
  { "w",       watch_file,            "Watch file",                     },

  -- ui
  { "<Space>", toggle_summary,        "Toggle summary",                 },
  { "s",       open_summary,          "Open summary",                   },
  { "v",       open_output,           "Output",                         },
  { "V",       open_output_panel,     "Output panel",                   },

  -- jump
  { "]t",      goto_next_test,        "Next test",            k =  "l", },
  { "[t",      goto_prev_test,        "Previous test",        k =  "l", },
  { "]T",      goto_next_failed_test, "Next failed test",     k =  "l", },
  { "[T",      goto_prev_failed_test, "Previous failed test", k =  "l", },
}

keys = require("mudox.util.keymap").lazy_keys(keys, {
  key_prefix = "<leader>c",
  desc_prefix = "Neotest",
})

return keys
