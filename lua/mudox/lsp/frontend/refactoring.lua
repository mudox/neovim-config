local M = {}

local function setup_keymaps(bufnr)
  local function b(t)
    t.buffer = bufnr
  end

  -- stylua: ignore start
  local keys = {
    ['\\'] = {
      r = b { vim.lsp.buf.rename,                   "LSP rename" },
      -- `a` for actions-preview plugin
    },
  }
  -- stylua: ignore end

  require("which-key").register(keys)
end

local function setup_keymaps_on_attach()
  local gid = vim.api.nvim_create_augroup("mdx_lsp_setup_refactoring_keymaps", { clear = true })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = gid,
    desc = "Setup keymaps for LSP refactoring",
    callback = function(event)
      setup_keymaps(event.buf)
    end,
  })
end

function M.setup()
  setup_keymaps_on_attach()
end

return M
