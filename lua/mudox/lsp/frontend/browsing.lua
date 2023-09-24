local M = {}

local function toggle_inlay_hint()
  vim.lsp.inlay_hint(0)
end

local function setup_keymaps(bufnr)
  -- stylua: ignore start
  local keys = {
    g = {
      x = { vim.lsp.buf.declaration,                   "Goto declaration" },

      d = { "<Cmd>Telescope lsp_definitions<Cr>",      "Goto definitions" },
      y = { "<Cmd>Telescope lsp_type_definitions<Cr>", "Goto type definitions" },
      m = { "<Cmd>Telescope lsp_implementations<Cr>",  "Goto implementations" },
      r = { "<Cmd>Telescope lsp_references<Cr>",       "Goto references" },

      D = { "<Cmd>Glance definitions<Cr>",             "Glance: goto definitions" },
      Y = { "<Cmd>Glance type_definitions<Cr>",        "Glance: goto type definitions" },
      M = { "<Cmd>Glance implementations<Cr>",         "Glance: goto implementations" },
      R = { "<Cmd>Glance references<Cr>",              "Glance: goto references" },
    },

    K   = { vim.lsp.buf.hover,                         "LSP hover" },
    gk  = { vim.lsp.buf.signature_help,                "LSP signature help" },

    gh  = { toggle_inlay_hint,                         "Toggle LSP inlay hint" },
  }

  local ikeys = {
    ["<C-k>"] = { vim.lsp.buf.signature_help,          "LSP Signature Help" },
  }
  -- stylua: ignore end

  for _, v in pairs(keys) do
    v.buffer = bufnr
  end
  require("which-key").register(keys)

  for _, v in pairs(ikeys) do
    v.buffer = bufnr
  end
  require("which-key").register(ikeys, { mode = "i" })
end

local function setup_on_attach()
  require("mudox.util").on.lsp_attach(function(_, bufnr)
    setup_keymaps(bufnr)
  end)
end

function M.setup()
  setup_on_attach()
end

return M
