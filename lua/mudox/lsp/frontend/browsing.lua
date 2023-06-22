local M = {}

local function toggle_inlay_hint()
  vim.lsp.buf.inlay_hint(0)
end

local function setup_keymaps(bufnr)
  local function b(t)
    t.buffer = bufnr
    return t
  end

  -- stylua: ignore start
  local keys = {
    g = {
      x = b { vim.lsp.buf.declaration,                   "Goto Declaration" },

      d = b { "<Cmd>Telescope lsp_definitions<Cr>",      "Goto Definitions" },
      y = b { "<Cmd>Telescope lsp_type_definitions<Cr>", "Goto Type Definitions" },
      m = b { "<Cmd>Telescope lsp_implementations<Cr>",  "Goto Implementations" },
      r = b { "<Cmd>Telescope lsp_references<Cr>",       "Goto References" },

      D = b { "<Cmd>Glance definitions<Cr>",             "Glance: Goto Definitions" },
      Y = b { "<Cmd>Glance type_definitions<Cr>",        "Glance: Goto Type Definitions" },
      M = b { "<Cmd>Glance implementations<Cr>",         "Glance: Goto Implementations" },
      R = b { "<Cmd>Glance references<Cr>",              "Glance: Goto References" },
    },

    K   = b { vim.lsp.buf.hover,                         "LSP Hover" },
    gk  = b { vim.lsp.buf.signature_help,                "LSP Signature Help" },

    gh  = b { toggle_inlay_hint,                         "Toggle LSP Inlay Hint" },
  }

  require("which-key").register(keys)

  keys = {
    ["<C-k>"] = b { vim.lsp.buf.signature_help,          "LSP Signature Help" },
  }
  -- stylua: ignore end

  require("which-key").register(keys, { mode = "i" })
end

local function setup_on_attach()
  require("mudox.util").on.lsp_attach(function(client, bufnr)
    setup_keymaps(bufnr)
  end)
end

function M.setup()
  setup_on_attach()
end

return M
