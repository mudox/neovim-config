local u = require("mudox.plugin.overseer.util")

-- stylua: ignore
local keys = {
  -- task list panel
  { "v",            "Toggle",                      "Toggle list",            },

  -- run task
  { "n",            "Build",                       "Build new task",         },

  { "c",            "RunCmd",                      "Run shell command",      },
  { ":",            "RunCmd",                      "Run shell command",      },

  { "<Cr>",         "Run",                         "Run template",           },

  { "r",            u.on_task("run"),              "Run task",               },

  { "q",            u.quick_run,                   "Quick run"               },
  { "w",            u.watch_run,                   "Watch & run",            },

  -- on last task
  { ".",            u.on_last_task('restart'),     "Rerun last",             },
  { "<C-j><C-j>",   u.save_rerun,                  "Rerun last",             mode = 'i' },
  { "e",            u.on_last_task('edit'),        "Edit last",              },
  { "<C-s>",        u.on_last_task('open hsplit'), "Split last",             },
  { "<C-v>",        u.on_last_task('open vsplit'), "VSplit last",            },

  -- action
  { "a",            "QuickAction",                 "Perform on last",        },
  { "o",            "TaskAction",                  "Perform on ...",         },

  -- tasks bundle
  { "S",            "SaveBundle",                  "Save task bundle",       },
  { "R",            "LoadBundle",                  "Load & run task bundle", },
  { "L",            "LoadBundle!",                 "Load task bundle",       },
  { "D",            "DeleteBundle",                "Delete task bundle",     },

  -- info
  { "<leader>vo ✓", "Info",                        "Overseer ✓",             },
}

return K.lazy_keys(keys, {
  key_prefix = "<leader>r",
  cmd_prefix = "Overseer",
})
