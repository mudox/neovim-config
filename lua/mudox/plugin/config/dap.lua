-- vim: fdm=marker fmr=〈,〉

-- Setup 〈

local dap = require("dap")

-- 〉

-- Mappings 〈

local function map(from, to)
  local nlua = require("mudox.keymap").nlua
  nlua(from, ('require("dap").%s'):format(to))
end

-- flow control
map("<F5>", "continue()")
map("<F10>", "step_over()")
map("<F11>", "step_into()")
map("<F12>", "step_out()")

-- toggle breakpoint
map(",db", "toggle_breakpoint()")
-- add conditional breakpoint
map(",dc", "set_breakpoint(vim.fn.input('Breakpoint condition: '))")
-- add log point
map(",dp", "set_breakpoint(nil, nil, vim.fn.input('Log point message: '))")

-- repl
map(",d:", "repl.open()")

-- retry last debug session
map(",d<Space>", "require('dap').run_last()")

-- 〉

-- Signs 〈

-- stylua: ignore start
vim.cmd([[
hi default link DapBreakpoint DiagnosticSignInfo
hi default link DapBreakpointCondition DiagnosticSignWarn
hi default link DapLogPoint DiagnosticSignDebug
hi default link DapStopped DiagnosticSignError
hi default link DapBreakpointRejected DiagnosticSignError
]])

local signs = {
  { name = "DapBreakpoint",          text = " " },
  { name = "DapBreakpointCondition", text = " " },
  { name = "DapLogPoint",            text = " " },
  { name = "DapStopped",             text = " " },
  { name = "DapBreakpointRejected",  text = " " },
}
-- stylua: ignore end
for _, sign in ipairs(signs) do
  print(vim.inspect(sign))
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text })
end

-- 〉

