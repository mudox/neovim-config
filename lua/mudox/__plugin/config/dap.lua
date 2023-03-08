-- vim: fdm=marker fmr=\ 〈,\ 〉

-- Setup 〈

local dap = require("dap")

dap.defaults.fallback.terminal_win_cmd = "6split new"
dap.defaults.python.terminal_win_cmd = "6split new"

-- 〉

-- Mappings 〈

local nreq = require("mudox.keymap").nreq

-- stylua: ignore start

-- flow control
nreq("<F5>",      'dap', "continue()")
nreq("<C-Left>",  'dap', "continue()")

nreq("<F10>",     'dap', "step_over()")
nreq("<C-Right>", 'dap', "step_over()")

nreq("<F11>",     'dap', "step_into()")
nreq("<C-Down>",  'dap', "step_into()")

nreq("<F12>",     'dap', "step_out()")
nreq("<C-Up>",    'dap', "step_out()")

-- stylua: ignore end

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dap-repl",
  callback = function()
    require("dap.ext.autocompl").attach()
  end,
})
