local n = vim.notify

local title = "Try Notify"

n("Error message", vim.log.levels.ERROR, {
  timeout = 10000,
  title = title,
})

n("Warn message", vim.log.levels.WARN, {
  timeout = 10000,
  title = title,
})

n("Info message", vim.log.levels.INFO, {
  timeout = 10000,
  title = title,
})

n("Debug message", vim.log.levels.DEBUG, {
  timeout = 10000,
  title = title,
})
