-- stylua: ignore
local keys = {
  { ":", "",                                                                              "Trouble",               },

  { "x", "diagnostics toggle filter.buf=0",                                               "Document diagnostics",  },
  { "e", "diagnostics toggle filter.buf=0 filter.severity=vim.diagnostic.severity.ERROR", "Document errors",       },
  { "X", "diagnostics toggle",                                                            "Workspace diagnostics", },
  { "E", "diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR",              "Workspace errors",      },

  { "s", "symbols toggle",                                                                "Document symbols",      },

  { "L", "lsp toggle focus=false win.position=right",                                     "LSP inspectors",        },

  { "l", "loclist",                                                                       "Loclist",               },
  { "q", "quickfix",                                                                      "Quickfix",              },

  { "r", "lsp_references",                                                                "References",            },
}
keys = K.lazy_keys(keys, {
  key_prefix = "<leader>x",
  main_cmd = "Trouble",
  desc_prefix = "Trouble",
})

local cascade_diagnostics = {
  mode = "diagnostics",
  filter = function(items)
    local severity = vim.diagnostic.severity.HINT
    for _, item in ipairs(items) do
      severity = math.min(severity, item.severity)
    end
    return vim.tbl_filter(function(item)
      return item.severity == severity
    end, items)
  end,
}

local function opts()
  local i = require("mudox.ui.icon")
  local icons = {
    -- stylua: ignore
    indent = {
      fold_open   = i.chevron.down .. ' ',
      fold_closed = i.chevron.right .. ' ',
      -- top         = "│  ",
      -- middle      = "├╴╴",
      -- last        = "╰╴╴",
      top         = "  ",
      middle      = "  ",
      last        = "  ",
      ws          = "  ",
    },
  }

  local ui_keys = {
    -- j = "next",
    -- k = "prev",
  }

  local modes = {
    cascade_diagnostics,
  }

  return {
    auto_preview = false,

    indent_guides = true,
    icons = icons,

    keys = ui_keys,

    -- modes = modes,
  }
end

return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = keys,
  opts = opts,
}
