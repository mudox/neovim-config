-- vim: fdm=marker fmr=〈,〉

local dap = require("dap")
local dapui = require("dapui")
local nlua = require("mudox.keymap").nlua

nlua("<M-/>d", "require('dapui').toggle()")

-- Setup 〈

-- TODO: add adapter & configuration settings here
dapui.setup({})

-- 〉

-- Open dap-ui windows automatically 〈

local record -- notify notification record

local function info(msg, level)
  level = level or "info"
  local opts = { icon = " ", title = "DAP", replace = record }
  record = require('notify')(msg, level, opts)
end

local eid = 'mudox.config.dap-ui'

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
