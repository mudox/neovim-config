local u = require("mudox.plugin.overseer.util")

-- stylua: ignore start
local function k(keys) return K.p("r") .. keys end
local function c(args) return ("<Cmd>Overseer%s<Cr>"):format(args) end
-- stylua: ignore en


-- stylua: ignore
local keys = {
  -- task list panel
  { k"v",     c"Toggle",                  desc = "tasks list",     },
  { K.p"wr",  c"Toggle",                  desc = "overseer",       },

  { k"<Cr>",  c"Run",                     desc = "run task",       },
  { k":",     c"Shell",                   desc = "run cmd",        },

  { k"r",     u.on_task("run"),           desc = "run task",       },

  { k"q",     u.quick_run,                desc = "quick run"       },
  { k"w",     u.watch_run,                desc = "watch & run",    },

  -- on last task
  { k".",     u.last_task("restart"),     desc = "rerun last",     },
  -- { k"<C-j><C-j>",   u.save_rerun,        desc =           "rerun last",             mode = "i" },
  { k"e",     u.last_task("edit"),        desc = "edit last",      },
  { k"<C-s>", u.last_task("open hsplit"), desc = "split last",     },
  { k"<C-v>", u.last_task("open vsplit"), desc = "vsplit last",    },

  -- action
  { k"o",     c"TaskAction",              desc = "perform on ...", },

  -- info
  { K.p"vo",  K.c"checkhealth overseer",  desc = "overseer",       },
}

return keys
