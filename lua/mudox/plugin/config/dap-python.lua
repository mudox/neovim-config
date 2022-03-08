local dap_python = require("dap-python")

dap_python.setup("~/.local/share/nvim/debugger_adaptors/debugpy/bin/python")
dap_python.test_runner = "pytest"

local ncmd = require("mudox.keymap").ncmd
ncmd(",dtm", "lua require('dap-python').test_method()")
ncmd(",dtc", "lua require('dap-python').test_class()")
ncmd(",ds", "lua require('dap-python').debug_selection()")
