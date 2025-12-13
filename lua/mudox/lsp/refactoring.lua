local function code_actions()
  require("actions-preview").code_actions()
end

local function tiny_code_actions()
  require("tiny-code-action").code_action {}
end

-- stylua: ignore start
K.nmap("\\r", vim.lsp.buf.rename,                        { desc = "[lsp] rename"             })
K.nmap("\\a", tiny_code_actions,                         { desc = "[lsp] tiny code actions"  })
K.nmap("\\A", code_actions,                              { desc = "[lsp] code actions"       })
K.nmap("\\C", vim.lsp.document_color.color_presentation, { desc = "[lsp] color presentation" })
-- stylua: ignore end
