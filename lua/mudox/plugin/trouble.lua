local function keys()
  local op = {
    name = "trouble item (<C-x>)",
    next = function()
      require("trouble").next { skip_groups = true, jump = true }
    end,
    prev = function()
      require("trouble").prev { skip_groups = true, jump = true }
    end,
  }

-- stylua: ignore
local keys = {
  { ":",      "",                                                                              "Trouble",               },

  { "x",      "diagnostics toggle filter.buf=0",                                               "Document diagnostics",  },
  { "e",      "diagnostics toggle filter.buf=0 filter.severity=vim.diagnostic.severity.ERROR", "Document errors",       },
  { "X",      "diagnostics toggle",                                                            "Workspace diagnostics", },
  { "E",      "diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR",              "Workspace errors",      },

  { "s",      "symbols toggle",                                                                "Document symbols",      },

  { "L",      "lsp toggle focus=false win.position=right",                                     "LSP inspectors",        },

  { "l",      "loclist toggle",                                                                "Loclist",               },
  { "q",      "quickfix toggle",                                                               "Quickfix",              },

  { "r",      "lsp_references toggle",                                                         "References",            },

  { "]<C-x> ✓", X.dirop.wrap(op, "next"),                                                      "Next trouble item",     },
  { "[<C-x> ✓", X.dirop.wrap(op, "prev"),                                                      "Previous trouble item", },
}
  keys = K.lazy_keys(keys, {
    key_prefix = "<leader>x",
    main_cmd = "Trouble",
  })

  return keys
end

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

      top         = "  ",
      middle      = "  ",
      last        = "  ",

      ws          = "  ",
    },
  }

  local modes = {
    cascade_diagnostics,

    test = {
      mode = "diagnostics",
      preview = {
        type = "split",
        relative = "win",
        position = "right",
        size = 0.3,
      },
    },
  }

  return {
    -- modes = modes,

    indent_guides = true,
    icons = icons,

    auto_preview = false,
  }
end

return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = keys(),
  opts = opts,
}
