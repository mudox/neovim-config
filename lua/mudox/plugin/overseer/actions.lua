local duplicate = {
  desc = "create a new task from existing task",
  run = function(task)
    local ov = require("overseer")

    local new_task = ov.new_task {
      name = "[DUP] " .. task.name,

      cmd = task.cmd,
      args = task.args,
      cwd = task.cwd,
      env = task.env,
    }

    ov.run_action(new_task, "edit")
  end,
}

local run = {
  desc = "start or restart task",
  run = function(task)
    local ov = require("overseer")
    local s = task.status

    if s == "PENDING" then
      ov.run_action(task, "start")
    elseif s == "SUCCESS" or s == "FAILURE" or s == "CANCELED" then
      ov.run_action(task, "restart")
    end
  end,
}

return {
  ["duplicate"] = duplicate,
  ["run"] = run,
}
