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

function M.setup()
  vim.diagnostic.config {
    update_in_insert = false,

    severity_sort = true,

    signs = true,

    underline = {
      severity = vim.diagnostic.severity.WARN,
    },

    virtual_text = {
      severity = vim.diagnostic.severity.WARN,
      spacing = 4,
      prefix = "󰅂",
    },

    float = {
      source = "always",
    },
  }

  setup_signs()
end

return M
