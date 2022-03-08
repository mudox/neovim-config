-- vim: fdm=marker fmr=〈,〉

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

-- TODO: add adapter & configuration settings here
dapui.setup {}

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
  dapui.open('sidebar')
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
