local M = {}

local function setup_keymaps(bufnr)
  local function b(t)
    t.buffer = bufnr
    return t
  end

  -- stylua: ignore start
  local keys = {
    g = {
      D = b { vim.lsp.buf.declaration,                   "Goto Declaration" },
      d = b { "<Cmd>Telescope lsp_definitions<Cr>",      "Goto Definitions" },
      t = b { "<Cmd>Telescope lsp_type_definitions<Cr>", "Goto Type Definitions" },
      I = b { "<Cmd>Telescope lsp_implementations<Cr>",  "Goto Implementations" },
      r = b { "<Cmd>Telescope lsp_references<Cr>",       "Goto References" },
    },
  }
  -- stylua: ignore end

  require("which-key").register(keys)
end

local function setup_keymaps_on_attach()
  local gid = vim.api.nvim_create_augroup("mdx_lsp_setup_code_navigation_keymaps", { clear = true })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = gid,
    desc = "Setup keymaps for LSP code navigation",
    callback = function(event)
      setup_keymaps(event.buf)
    end,
  })
end

function M.setup()
  setup_keymaps_on_attach()
end

return M
