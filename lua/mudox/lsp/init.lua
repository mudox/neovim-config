local i = require("mudox.ui").icons

local function setup()
  -- Icons

  local signs = {
    { name = "DiagnosticSignError", text = i.error },
    { name = "DiagnosticSignWarn", text = i.warn },
    { name = "DiagnosticSignInfo", text = i.info },
    { name = "DiagnosticSignHint", text = i.hint },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text })
  end

  -- Diagnostic configuration

  local config = {
    severity_sort = true,
    underline = false,
    update_in_insert = false,
    virtual_text = false,
    virtual_lines = true, -- for `lsp_lines.nvim`
    float = {
      focusable = false,
      border = "rounded",
      source = "always",
      header = " DIAGNOSTICS",
      prefix = "⋅ ",
    },
  }

  vim.diagnostic.config(config)

  -- Float window border

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

return {
  setup = setup,
}
