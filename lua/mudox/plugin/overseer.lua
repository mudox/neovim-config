-- stylua: ignore
local keys = {
  -- task list
  { "<Space>",          "Toggle",         "Toggle list",                       },
  { "<C-S-Cr>",         "Toggle",         "Toggle list",            k =  "l",  },

  -- launch task
  { "<Cr>",             "Run",            "Run template",                      },
  { "<C-Cr>",           "Run",            "Run template",           k =  "l",  },
  { "c",                "RunCmd",         "Run shell command",                 },
  { ":",                "RunCmd",         "Run shell command",                 },
  { "n",                "Build",          "Build new task",                    },

  { ".",                "RestartLast",    "Run last",                          },

  { "w",                "WatchRun",       "Watch & run",                       },

  -- manage task
  { "a",                "QuickAction",    "Perform on last",                   },
  { "A",                "TaskAction",     "Perform on ...",                    },

  -- save / restore tasks
  { "S",                "SaveBundle",     "Save task bundle",                  },
  { "R",                "LoadBundle",     "Load & run task bundle",            },
  { "L",                "LoadBundle!",    "Load task bundle",                  },
  { "D",                "DeleteBundle",   "Delete task bundle",                },

  -- info
  { "<leader>vo",       "Info",           "Overseer",               k =  "ld", },
}

keys = K.lazy_keys(keys, {
  key_prefix = "<leader>r",
  cmd_prefix = "Overseer",
  desc_prefix = "Overseer",
})

local function run_last()
  -- https://github.com/stevearc/overseer.nvim/blob/master/doc/recipes.md#restart-last-task

  vim.api.nvim_create_user_command("OverseerRestartLast", function()
    local overseer = require("overseer")

    local tasks = overseer.list_tasks { recent_first = true }
    if vim.tbl_isempty(tasks) then
      vim.notify("No overseer task found", vim.log.levels.INFO)
    else
      overseer.run_action(tasks[1], "restart")
    end
  end, {})
end

local function watch_run()
  vim.api.nvim_create_user_command("OverseerWatchRun", function()
    local overseer = require("overseer")

    overseer.run_template({ name = "quick run" }, function(task)
      if task then
        task:add_component { "restart_on_save", paths = { vim.fn.expand("%:p") } }

        local main_win = vim.api.nvim_get_current_win()
        overseer.run_action(task, "open vsplit")
        vim.api.nvim_set_current_win(main_win)
      else
        vim.notify("Failed to run task: quick run", vim.log.levels.ERROR)
      end
    end)
  end, {})
end

-- TODO: adapt to find all AP actions
---@diagnostic disable-next-line: unused-local, unused-function
local function local_shell_scripts()
  local files = require("overseer.files")

  return {
    generator = function(opts, cb)
      local scripts = vim.tbl_filter(function(filename)
        return filename:match("%.z?sh$")
      end, files.list_files(opts.dir))

      local templates = {}
      for _, filename in ipairs(scripts) do
        table.insert(templates, {
          name = "Run " .. filename,
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

      cb(templates)
    end,
  }
end

local templates = {
  "builtin",

  "mudox.quick_run",
  "mudox.run_neovim_lua_script",
}

local function opts()
  local border = require("mudox.ui.icon").border.corner

  local task_list = {
    direction = "right",
    separator = "",

  -- stylua: ignore
  bindings = {
    -- open task output window
    -- p         = "TogglePreview",
    -- o         = "Open",
    -- ["<C-f>"] = "OpenFloat",
    -- ["<C-v>"] = "OpenVsplit",
    -- ["<C-s>"] = "OpenSplit",

    -- navigate
    ["<C-n>"]    = "NextTask",
    ["<C-p>"]    = "PrevTask",

    -- window width
    -- edgy.nvim fixed the panel width
    -- ["]"]     = "IncreaseWidth",
    -- ["["]     = "DecreaseWidth",

    -- scroll
    ["<C-j>"]    = "ScrollOutputDown",
    ["<C-k>"]    = "ScrollOutputUp",

    -- detail
    m            = "IncreaseDetail",
    l            = "DecreaseDetail",
    M            = "IncreaseAllDetail",
    L            = "DecreaseAllDetail",
  },
  }

  return {
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
      padding = 8,
      border = border,
      win_opts = {
        winblend = 0,
      },
    },
    help_win = {
      border = border,
    },
  }
end

local function config()
  -- !!! order matters
  require("dap")
  require("overseer").setup(opts())
  require("dap.ext.vscode").json_decode = require("overseer.json").decode

  run_last()
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
  config = config,
}
