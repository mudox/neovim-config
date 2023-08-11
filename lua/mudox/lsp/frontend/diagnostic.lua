local d9 = vim.diagnostic

local M = {}

local function setup_signs()
  local i = require("mudox.ui").icons
  -- stylua: ignore start
  local signs = {
    { "DiagnosticSignError", i.error },
    { "DiagnosticSignWarn",  i.warn },
    { "DiagnosticSignInfo",  i.info },
    { "DiagnosticSignHint",  i.hint },
  }
  -- stylua: ignore end

  for _, v in ipairs(signs) do
    vim.fn.sign_define(v[1], { texthl = v[1], text = v[2] })
  end
end

local function config()
  d9.config {
    update_in_insert = false,

    severity_sort = true,

    signs = true,

    underline = {
      severity = d9.severity.WARN,
    },

    virtual_text = {
      severity = d9.severity.WARN,
      spacing = 4,
      prefix = "󰅂",
    },

    float = {
      source = "always",
    },
  }
end

local function jump(next, severity)
  local go = next and d9.goto_next or d9.goto_prev
  severity = severity and d9.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end

local function toggle()
  local function notify(msg)
    vim.notify(msg, vim.log.levels.INFO, { title = "LSP" })
  end

  if d9.is_disabled() then
    d9.enable()
    notify("Disgnostic enabled")
  else
    d9.disable()
    notify("Disgnostic disabled")
  end
end

local function lsp_lines()
  require("lsp_lines").toggle()
end

local function setup_keymaps(bufnr)
  local function b(t)
    t.buffer = bufnr
    return t
  end

  -- stylua: ignore start
  local keys = {
    ["]d"]  = b { jump(true),             "Goto next issue" },
    ["[d"]  = b { jump(false),            "Goto previous issue" },
    ["]E"]  = b { jump(true, "ERROR"),    "Goto next error" },
    ["[E"]  = b { jump(false, "ERROR"),   "Goto previous error" },

    ["gl"]  = b { d9.open_float,          "Show issue(s) of current line" },
    ["gL"]  = b { lsp_lines,              "Toggle LSP lines" },

    ["yod"] = b { toggle,                 "Toggle diagnostic" },
  }
  -- stylua: ignore end

  require("which-key").register(keys)
end

local function setup_keymaps_on_attach()
  local gid = vim.api.nvim_create_augroup("mdx_lsp_setup_diagnostic_keymaps", { clear = true })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = gid,
    desc = "Setup buffer local keymaps for LSP diagnostic",
    callback = function(event)
      setup_keymaps(event.buf)
    end,
  })
end

function M.setup()
  config()
  setup_signs()
  setup_keymaps_on_attach()
end

return M
