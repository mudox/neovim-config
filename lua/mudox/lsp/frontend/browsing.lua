local M = {}

local function setup_keymaps(_, bufnr)
  local function toggle_inlay_hint()
    vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled(0))
  end

  -- stylua: ignore
  local keys = {
    gx        = { vim.lsp.buf.declaration,                   "[LSP] Goto declaration"           },

    gd        = { "<Cmd>Telescope lsp_definitions<Cr>",      "[LSP] Goto definitions"           },
    gy        = { "<Cmd>Telescope lsp_type_definitions<Cr>", "[LSP] Goto type definitions"      },
    gm        = { "<Cmd>Telescope lsp_implementations<Cr>",  "[LSP] Goto implementations"       },
    gr        = { "<Cmd>Telescope lsp_references<Cr>",       "[LSP] Goto references"            },

    gD        = { "<Cmd>Glance definitions<Cr>",             "[Glance] Goto definitions"        },
    gY        = { "<Cmd>Glance type_definitions<Cr>",        "[Glance] Goto type definitions"   },
    gM        = { "<Cmd>Glance implementations<Cr>",         "[Glance] Goto implementations"    },
    gR        = { "<Cmd>Glance references<Cr>",              "[Glance] Goto references"         },

    K         = { vim.lsp.buf.hover,                         "[LSP] Hover"                      },
    gk        = { vim.lsp.buf.signature_help,                "[LSP] Signature help"             },

    ["yoH"]   = { toggle_inlay_hint,                         "[LSP] inlay hint"                 },

    ["<C-k>"] = { vim.lsp.buf.signature_help,                "[LSP] Signature Help", mode = "i" },
  }

  for _, v in pairs(keys) do
    v.buffer = bufnr
  end
  require("which-key").register(keys)
end

function M.setup()
  U.on.lsp_attach(setup_keymaps)
end

return M
