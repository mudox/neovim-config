local kb = require("mudox.keyboard")

-- stylua: ignore
local keys = {
  -- task list
  { "<Space>",          "Toggle",         "Toggle task list"       },
  { "-" .. kb.cs["cr"], "Toggle",         "Toggle task list"       },

  -- info
  { "i",                "Info",           "Diagnostic info"        },

  -- launch task
  { "r",                "Run",            "Run task template"      },
  { "-" .. kb.c["cr"],  "Run",            "Run task template"      },
  { ".",                "RestartLast",    "Run last task"          },
  { "c",                "RunCmd",         "Run shell command"      },
  { "n",                "Build",          "Build new task"         },
  { "w",                "WatchRun",       "Watch & run"            },

  -- manage task
  { "a",                "QuickAction",    "Perform quick action"   },
  { "A",                "TaskAction",     "Perform task action"    },

  -- save / restore tasks
  { "S",                "SaveBundle",     "Save task bundle"       },
  { "R",                "LoadBundle",     "Load & run task bundle" },
  { "L",                "LoadBundle!",    "Load task bundle"       },
  { "D",                "DeleteBundle",   "Delete task bundle"     },
}

keys = require("mudox.util.keymap").lazy_keys(keys, {
  key_prefix = "<leader>r",
  cmd_fmt = "<Cmd>Overseer%s<Cr>",
  desc_prefix = "Overseer",
})

-- restarts the most recent overseer task
local function run_last_command()
  vim.api.nvim_create_user_command("OverseerRestartLast", function()
    local overseer = require("overseer")
    local tasks = overseer.list_tasks { recent_first = true }
    if vim.tbl_isempty(tasks) then
      vim.notify("No tasks found", vim.log.levels.INFO)
    else
      overseer.run_action(tasks[1], "restart")
    end
  end, {})
end

local function watch_run()
  vim.api.nvim_create_user_command("OverseerWatchRun", function()
    local overseer = require("overseer")
    overseer.run_template({ name = "run script" }, function(task)
      if task then
        task:add_component { "restart_on_save", paths = { vim.fn.expand("%:p") } }
        local main_win = vim.api.nvim_get_current_win()
        overseer.run_action(task, "open vsplit")
        vim.api.nvim_set_current_win(main_win)
      else
        vim.notify(
          'Template "run script" currently does not supports filetype ' .. vim.bo.filetype,
          vim.log.levels.ERROR
        )
      end
    end)
  end, {})
end

-- this template provider will find all shell scripts in the current directory and create tasks for them
-- https://github.com/stevearc/overseer.nvim/blob/master/doc/recipes.md#run-shell-scripts-in-the-current-directory
local function local_shell_scripts()
  local files = require("overseer.files")

  return {
    generator = function(opts, cb)
      local scripts = vim.tbl_filter(function(filename)
        return filename:match("%.sh$")
      end, files.list_files(opts.dir))
      local ret = {}
      for _, filename in ipairs(scripts) do
        table.insert(ret, {
          name = filename,
          params = {
            args = { optional = true, type = "list", delimiter = " " },
          },
          builder = function(params)
            return {
              cmd = { files.join(opts.dir, filename) },
              args = params.args,
            }
          end,
        })
      end

      cb(ret)
    end,
  }
end

local templates = {
  "builtin",

  "mudox.run_script",
  "mudox.run_neovim_lua_script",
}

local border = require("mudox.ui.icons").border.corner

local task_list = {
  direction = "right",
  bindings = {
    -- open
    -- ["o"] = "Open",
    -- ["<C-f>"] = "OpenFloat",
    -- ["<C-v>"] = "OpenVsplit",
    -- ["<C-s>"] = "OpenSplit",

    -- navigate
    ["C-j"] = "NextTask",
    ["C-k"] = "PrevTask",

    -- window width
    -- ["]"] = "IncreaseWidth",
    -- ["["] = "DecreaseWidth",

    -- scroll
    -- ["C-j"] = "ScrollOutputDown",
    -- ["C-k"] = "ScrollOutputUp",

    -- detail
    ["<C-l>"] = false,
    ["<C-h>"] = false,
    ["]"] = "IncreaseDetail",
    ["["] = "DecreaseDetail",
    ["L"] = false,
    ["H"] = false,
    ["}"] = "IncreaseAllDetail",
    ["{"] = "DecreaseAllDetail",
  },
}

local opts = {
  templates = templates,

  task_list = task_list,
  confirm = {
    border = border,
    win_opts = {
      winblend = 0,
    },
  },
  task_launcher = {
    border = border,
    win_opts = {
      winblend = 0,
    },
  },
  form = {
    border = border,
    win_opts = {
      winblend = 0,
    },
  },
  task_win = {
    padding = 4,
    border = border,
    win_opts = {
      winblend = 0,
    },
  },
}

local function config(_, o)
  require("overseer").setup(o)

  -- recipes from https://github.com/stevearc/overseer.nvim/blob/master/doc/recipes.md
  run_last_command()
  -- local_shell_scripts()

  -- https://github.com/stevearc/overseer.nvim/blob/master/doc/tutorials.md#build-a-c-file
  watch_run()
end

return {
  "stevearc/overseer.nvim",
  cmd = {
    "OverseerRun",
    "OverseerToggle",
    "OverseerInfo",
    "OverseerBuild",
  },
  keys = keys,
  opts = opts,
  config = config,
}
