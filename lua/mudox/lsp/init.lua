-- stylua: ignore start
local signs = {
  { name = "DiagnosticSignError", text = " " },
  { name = "DiagnosticSignWarn",  text = " " },
  { name = "DiagnosticSignHint",  text = " " },
  { name = "DiagnosticSignInfo",  text = " " },
}
-- stylua: ignore end

local function setup()
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text })
  end

  -- diagnostic float window
  local config = {
    virtual_text = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      border = "rounded",
      source = "always",
      header = " DIAGNOSTICS",
      prefix = "  ",
    },
  }

  vim.diagnostic.config(config)

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
