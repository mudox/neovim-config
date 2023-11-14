local M = {}

local function toggle_inlay_hint()
  vim.lsp.inlay_hint(0)
end

local function setup_keymaps(bufnr)
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

    [";th"]   = { toggle_inlay_hint,                         "[LSP] Toggle inlay hint"          },

    ["<C-k>"] = { vim.lsp.buf.signature_help,                "[LSP] Signature Help", mode = "i" },
  }

  for _, v in pairs(keys) do
    v.buffer = bufnr
  end
  require("which-key").register(keys)
end

local function setup_on_attach()
  require("mudox.util.on").lsp_attach(function(_, bufnr)
    setup_keymaps(bufnr)
  end)
end

function M.setup()
  setup_on_attach()
end

return M
