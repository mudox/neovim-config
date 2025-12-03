local function code_actions()
  require("actions-preview").code_actions()
end

local function tiny_code_actions()
  require("tiny-code-action").code_action {}
end

-- stylua: ignore start
K.nmap("\\r", vim.lsp.buf.rename, { desc = "[LSP] Rename" })
K.nmap("\\A", code_actions, { desc = "[LSP] Code actions" })
K.nmap("\\a", tiny_code_actions, { desc = "[LSP] Tiny code actions" })
-- stylua: ignore end
