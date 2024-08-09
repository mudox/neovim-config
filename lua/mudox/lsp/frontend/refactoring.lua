local M = {}

local function setup_keymaps(_, bufnr)
  local function code_actions()
    require("actions-preview").code_actions()
  end

  local function tiny_code_actions()
    require("tiny-code-action").code_action()
  end

  -- stylua: ignore
  local keys = {
    { "\\r", vim.lsp.buf.rename, desc = "[LSP] Rename"            },
    { "\\A", code_actions,       desc = "[LSP] Code actions"      },
    { "\\a", tiny_code_actions,  desc = "[LSP] Tiny code actions" },
  }

  require("which-key").add(keys, { buffer = bufnr })
end

function M.setup()
  U.on.lsp_attach(setup_keymaps)
end

return M
