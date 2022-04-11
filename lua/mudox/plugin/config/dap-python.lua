local dap_python = require("dap-python")

dap_python.setup("~/.local/share/nvim/debugger_adaptors/debugpy/bin/python")
dap_python.test_runner = "pytest"
