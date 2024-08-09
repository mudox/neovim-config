local function default_task_name()
  local ft = vim.bo.filetype
  local map = {
    lua = "run neovim lua script",
    rust = "cargo run",
  }
  return map[ft] or "quick run"
end

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

local function save_rerun()
  vim.cmd.stopinsert()
  vim.cmd.update()
  on_last("restart")()
end

local function quick_run()
  local o = require("overseer")

  o.run_template({ name = default_task_name() }, function(task)
    if task then
      local main_win = vim.api.nvim_get_current_win()
      o.run_action(task, "open vsplit")
      vim.api.nvim_set_current_win(main_win)
    else
      vim.notify("Failed to run task", vim.log.levels.ERROR)
    end
  end)
end

local function watch_run()
  local o = require("overseer")

  o.run_template({ name = default_task_name() }, function(task)
    if task then
      task:add_component { "restart_on_save", paths = { vim.fn.expand("%:p") } }

      local main_win = vim.api.nvim_get_current_win()
      o.run_action(task, "open vsplit")
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
  { "<C-S-Cr> ✓", "Toggle",               "Toggle list",            },
  { "v",          "Toggle",               "Toggle list",            },

  -- launch task
  { "<Cr>",       "Run",                  "Run template",           },
  { "<C-Cr> ✓",   "Run",                  "Run template",           },
  { "c",          "RunCmd",               "Run shell command",      },
  { ":",          "RunCmd",               "Run shell command",      },
  { "n",          "Build",                "Build new task",         },
  { "q",          quick_run,              "Quick run",              },

  -- quick run & watch
  { "w",          watch_run,              "Watch & run",            },

  -- on last task
  { ".",          on_last('restart'),     "Rerun last",             },
  { "<C-k>r",     save_rerun,             "Rerun last",             mode = 'i' },
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
  { "<leader>vo ✓", "Info",               "Overseer ✓",             },
}
return K.lazy_keys(keys, {
  key_prefix = "<leader>r",
  cmd_prefix = "Overseer",
  desc_prefix = "Overseer",
})
