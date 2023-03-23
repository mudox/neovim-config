local keys = {
  { "<Space>", "<Cmd>OverseerToggle<Cr>", desc = "Toggle Task List" },

  { "i", "<Cmd>OverseerInfo<Cr>", desc = "Overseer Info" },

  { "r", "<Cmd>OverseerRun<Cr>", desc = "Run Task From Template" },
  { "R", "<Cmd>OverseerRunCmd<Cr>", desc = "Run Shell Command" },
  { "b", "<Cmd>OverseerBuild<Cr>", desc = "Build New Task" },

  { "a", "<Cmd>OverseerQuickAction<Cr>", desc = "Overseer Quick Action" },
  { "a", "<Cmd>OverseerTaskAction<Cr>", desc = "Overseer Task Action" },

  { "s", "<Cmd>OverseerSaveBundle<Cr>", desc = "Save Task Bundle" },
  { "l", "<Cmd>OverseerLoadBundle<Cr>", desc = "Load & Run Task Bundle" },
  { "L", "<Cmd>OverseerLoadBundle!<Cr>", desc = "Load Task Bundle" },
  { "d", "<Cmd>OverseerDeleteBundle<Cr>", desc = "Delete Task Bundle" },
}

for _, k in ipairs(keys) do
  k[1] = "<leader>r" .. k[1]
end

vim.list_extend(keys, {
  -- task list side pane
  { "<M-/>t", "<Cmd>OverseerToggle<Cr>", desc = "Toggle Task List (Overseer) Side Pane" },
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

-- this template provider will find all shell scripts in the current directory and create tasks for them
local function local_shell_scripts()
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

local function config(_, opts)
  require("overseer").setup(opts)

  -- recipes from https://github.com/stevearc/overseer.nvim/blob/master/doc/recipes.md
  run_last_command()
  local_shell_scripts()
end

local opts = {
  confirm = {
    border = "single",
  },
  form = {
    border = "single",
  },
  task_win = {
    border = "single",
  },
  templates = {
    "builtin",
    "mudox.run_script",
  },
}

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
