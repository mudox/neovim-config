local u = require("mudox.plugin.overseer.util")

-- stylua: ignore start
local function k(keys) return K.p("r") .. keys end
local function c(args) return ("<Cmd>Overseer%s<Cr>"):format(args) end
-- stylua: ignore en


-- stylua: ignore
local keys = {
  -- task list panel
  { k"v",     c"Toggle",                     "Toggle list",            },
  { K.p"wr",  c"Toggle",                     "[Overseer] Toggle",      },

  { k"<Cr>",  c"Run",                        "Run template",           },

  { k"r",     u.on_task("run"),              "Run task",               },

  { k"q",     u.quick_run,                   "Quick run"               },
  { k"w",     u.watch_run,                   "Watch & run",            },

  -- on last task
  { k".",     u.on_last_task('restart'),     "Rerun last",             },
  -- { k"<C-j><C-j>",   u.save_rerun,                  "Rerun last",             mode = 'i' },
  { k"e",     u.on_last_task('edit'),        "Edit last",              },
  { k"<C-s>", u.on_last_task('open hsplit'), "Split last",             },
  { k"<C-v>", u.on_last_task('open vsplit'), "VSplit last",            },

  -- action
  { k"o",     c"TaskAction",                 "Perform on ...",         },

  -- tasks bundle
  { k"S",     c"SaveBundle",                 "Save task bundle",       },
  { k"R",     c"LoadBundle",                 "Load & run task bundle", },
  { k"L",     c"LoadBundle!",                "Load task bundle",       },
  { k"D",     c"DeleteBundle",               "Delete task bundle",     },

  -- info
  { K.p"vo",  K.c"checkhealth overseer",     "Overseer",               },
}

return keys
