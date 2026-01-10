local M = {}

function M.task_name()
  local ft = vim.bo.filetype
  -- stylua: ignore
  local map = {
    lua  = "run by neovim",
    rust = "cargo run",
  }
  return map[ft] or "quick run"
end

function M.last_task(action)
  return function()
    -- ref: https://github.com/stevearc/overseer.nvim/blob/master/doc/recipes.md#restart-last-task
    local o = require("overseer")
    local tl = require("overseer.task_list")
    local tasks = o.list_tasks {
      status = {
        o.STATUS.SUCCESS,
        o.STATUS.FAILURE,
        o.STATUS.CANCELED,
      },
      sort = tl.sort_finished_recently,
    }
    if vim.tbl_isempty(tasks) then
      vim.notify("no tasks found", vim.log.levels.WARN)
    else
      local orig_win = vim.api.nvim_get_current_win()
      o.run_action(tasks[1], action)
      if action ~= "edit" then
        vim.api.nvim_set_current_win(orig_win)
      end
    end
  end
end

function M.on_task(action)
  return function()
    local ov = require("overseer")
    local task_list = require("overseer.task_list")

    local tasks = ov.list_tasks { unique = true, recent_first = true }
    if #tasks == 0 then
      vim.notify("No tasks available", vim.log.levels.WARN)
    elseif #tasks == 1 then
      ov.run_action(tasks[1], action)
    end

    local task_summaries = vim.tbl_map(function(task)
      return { name = task.name, id = task.id }
    end, tasks)

    vim.ui.select(task_summaries, {
      prompt = "Select task",
      kind = "overseer_task",
      format_item = function(task)
        return task.name
      end,
    }, function(task_summary)
      if task_summary then
        local task = assert(task_list.get(task_summary.id))
        ov.run_action(task, action)
      end
    end)
  end
end

function M.save_rerun()
  vim.cmd.stopinsert()
  vim.cmd.update()
  M.last_task("restart")()
end

function M.quick_run()
  local o = require("overseer")

  o.run_task({ name = M.task_name() }, function(task)
    if task then
      local orig_win = vim.api.nvim_get_current_win()

      task:open_output("vertical")
      -- fix: result window may scroll to right by some chars
      -- local term_win = vim.api.nvim_get_current_win()
      -- vim.defer_fn(function()
      --   vim.api.nvim_win_set_cursor(term_win, { 1, 0 })
      -- end, 400)

      vim.api.nvim_set_current_win(orig_win)
    else
      vim.notify("[overseer] quick run failed", vim.log.levels.ERROR)
    end
  end)
end

function M.watch_run()
  local o = require("overseer")

  o.run_task({ name = M.task_name() }, function(task)
    if task then
      task:add_component { "restart_on_save", paths = { vim.fn.expand("%:p") } }

      local main_win = vim.api.nvim_get_current_win()
      task:open_output("vertical")
      vim.api.nvim_set_current_win(main_win)
    else
      vim.notify("[overseer] watch & run failed", vim.log.levels.ERROR)
    end
  end)
end

return M
