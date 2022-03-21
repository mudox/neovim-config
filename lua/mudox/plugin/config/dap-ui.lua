-- vim: fdm=marker fmr=〈,〉
local i = require("mudox.ui").icons

local dap = require("dap")
local dapui = require("dapui")

local function map(from, to)
  local nlua = require("mudox.keymap").nlua
  nlua(from, ('require("dapui").%s'):format(to))
end

map("<M-/>d", "toggle()")
map("<M-/>h", "toggle('sidebar')")
map("<M-/>j", "toggle('tray')")

-- Setup 〈

dapui.setup {
  icons = { expanded = i.expanded, collapsed = i.collapsed },
  sidebar = {
    elements = {
      { id = "scopes", size = 0.25 },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
}

-- 〉

-- Open dap-ui windows automatically 〈

local record -- notify notification record

local function info(msg, level)
  level = level or "info"
  local opts = { icon = " ", title = "DAP", replace = record }
  record = require("notify")(msg, level, opts)
end

local eid = "mudox.dap-ui"

dap.listeners.after.event_initialized[eid] = function()
  dapui.open("sidebar")
  info("Debugging started")
end

dap.listeners.before.event_terminated[eid] = function()
  dapui.close()
  info("Debugging terminated", "warn")
end

dap.listeners.before.event_exited[eid] = function()
  dapui.close()
  info("Debugging exited")
end

-- 〉
