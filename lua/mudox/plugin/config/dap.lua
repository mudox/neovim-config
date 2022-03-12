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
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text })
end

-- 〉
