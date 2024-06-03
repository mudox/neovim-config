local function on_last(action)
  return function()
    -- https://github.com/stevearc/overseer.nvim/blob/master/doc/recipes.md#restart-last-task
    local overseer = require("overseer")

    local tasks = overseer.list_tasks { recent_first = true }
    if vim.tbl_isempty(tasks) then
      vim.notify("No overseer task found", vim.log.levels.INFO)
    else
      overseer.run_action(tasks[1], action)
    end
  end
end

local function watch_run()
  local overseer = require("overseer")

  local ft = vim.bo.filetype
  local name = "quick run"
  if ft == "lua" then
    name = "run neovim lua script"
  end

  overseer.run_template({ name = name }, function(task)
    if task then
      task:add_component { "restart_on_save", paths = { vim.fn.expand("%:p") } }

      local main_win = vim.api.nvim_get_current_win()
      overseer.run_action(task, "open vsplit")
      vim.api.nvim_set_current_win(main_win)
    else
      vim.notify("Failed to run task: quick run, unspported filetype?", vim.log.levels.ERROR)
    end
  end)
end

-- stylua: ignore
local keys = {
  -- task list
  { "<Space>",    "Toggle",               "Toggle list",            },
  { "<C-S-Cr>",   "Toggle",               "Toggle list",            k =  "l",  },
  { "v",          "Toggle",               "Toggle list",            },

  -- launch task
  { "<Cr>",       "Run",                  "Run template",           },
  { "<C-Cr>",     "Run",                  "Run template",           k =  "l",  },
  { "c",          "RunCmd",               "Run shell command",      },
  { ":",          "RunCmd",               "Run shell command",      },
  { "n",          "Build",                "Build new task",         },

  -- quick run & watch
  { "w",          watch_run,              "Watch & run",            },
  { "r",          watch_run,              "Watch & run",            },

  -- on last task
  { ".",          on_last('restart'),     "Rerun last",             },
  { "e",          on_last('edit'),        "Rerun last",             },
  { "<C-s>",      on_last('open hsplit'), "Split last",             },
  { "<C-v>",      on_last('open vsplit'), "VSplit last",            },

  -- perform action on task
  { "a",          "QuickAction",          "Perform on last",        },
  { "A",          "TaskAction",           "Perform on ...",         },

  -- save / restore tasks
  { "S",          "SaveBundle",           "Save task bundle",       },
  { "R",          "LoadBundle",           "Load & run task bundle", },
  { "L",          "LoadBundle!",          "Load task bundle",       },
  { "D",          "DeleteBundle",         "Delete task bundle",     },

  -- info
  { "<leader>vo", "Info",                 "Overseer",               k =  "ld", },
}

return K.lazy_keys(keys, {
  key_prefix = "<leader>r",
  cmd_prefix = "Overseer",
  desc_prefix = "Overseer",
})
