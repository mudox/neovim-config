local M = {}

local function setup_keymaps(_, bufnr)
  local function toggle_inlay_hint()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end

  local function hover()
    vim.lsp.buf.hover {
      border = { " " },
    }
  end

  -- stylua: ignore
  local keys = {
    { "gx",     vim.lsp.buf.declaration,                   desc = "[LSP] Goto declaration"           },

    -- Telescope
    { "gd",     "<Cmd>Telescope lsp_definitions<Cr>",      desc = "[LSP] Goto definitions"           },
    { "gy",     "<Cmd>Telescope lsp_type_definitions<Cr>", desc = "[LSP] Goto type definitions"      },
    { "gm",     "<Cmd>Telescope lsp_implementations<Cr>",  desc = "[LSP] Goto implementations"       },
    { "gr",     "<Cmd>Telescope lsp_references<Cr>",       desc = "[LSP] Goto references"            },

    -- Glance
    { "gD",     "<Cmd>Glance definitions<Cr>",             desc = "[Glance] Goto definitions"        },
    { "gY",     "<Cmd>Glance type_definitions<Cr>",        desc = "[Glance] Goto type definitions"   },
    { "gM",     "<Cmd>Glance implementations<Cr>",         desc = "[Glance] Goto implementations"    },
    { "gR",     "<Cmd>Glance references<Cr>",              desc = "[Glance] Goto references"         },

    -- in favor of hover.nvim
    { "K",      hover,                                     desc = "[LSP] Hover"                      },

    { "gk",     vim.lsp.buf.signature_help,                desc = "[LSP] Signature help"             },
    { "<C-k>k", vim.lsp.buf.signature_help,                desc = "[LSP] Signature Help",            mode = "i" },

    { "yoH",    toggle_inlay_hint,                         desc = "[LSP] inlay hint"                 },
  }

  for _, v in pairs(keys) do
    v.buffer = bufnr
  end
  require("which-key").add(keys)
end

function M.setup()
  On.lsp_attach(setup_keymaps)
end

return M
