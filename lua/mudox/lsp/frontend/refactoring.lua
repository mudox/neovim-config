local M = {}

local function setup_keymaps(_, bufnr)
  local function code_actions()
    require("actions-preview").code_actions()
  end

  -- stylua: ignore
  local keys = {
    ['\\'] = {
      r = { vim.lsp.buf.rename, "[LSP] Rename" },
      a = { code_actions,       "[LSP] Code actions" },
    },
  }

  require("which-key").register(keys, { buffer = bufnr })
end

function M.setup()
  U.on.lsp_attach(setup_keymaps)
end

return M
