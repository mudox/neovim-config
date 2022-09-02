local notify = require("notify")

local i = require("mudox.ui").icons
local icons = {
  ERROR = i.error,
  WARN = i.warn,
  INFO = i.info,
  DEBUG = i.debug,
  TRACE = i.trace,
}

local opts = {
  stages = "static",

  on_open = nil,

  on_close = nil,

  render = "default",

  timeout = 5000,

  max_width = nil,
  max_height = nil,

  background_colour = "#000000",

  minimum_width = 50,

  icons = icons,
}

notify.setup(opts)

vim.notify = notify
