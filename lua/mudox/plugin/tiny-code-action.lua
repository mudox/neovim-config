return {
  "rachartier/tiny-code-action.nvim",
  dependencies = { "plenary.nvim", "telescope.nvim" },
  -- event = "LspAttach", -- required in frontend/refactoring.lua
  opts = {
    backend = "difftastic",

    -- stylua: ignore
    signs = {
      ["quickfix"]               = { "󱌣 ", { link = "DiagnosticWarning" }},
      ["others"]                 = { " ", { link = "DiagnosticWarning" }},
      ["refactor"]               = { "󰚔 ", { link = "DiagnosticInfo"    }},
      ["refactor.move"]          = { "󱀱 ", { link = "DiagnosticInfo"    }},
      ["refactor.extract"]       = { "󰈊 ", { link = "DiagnosticError"   }},
      ["source.organizeImports"] = { "󰆧 ", { link = "DiagnosticWarning" }},
      ["source.fixAll"]          = { "󰁨 ", { link = "DiagnosticError"   }},
      ["source"]                 = { " ", { link = "DiagnosticError"   }},
      ["rename"]                 = { " ", { link = "DiagnosticWarning" }},
      ["codeAction"]             = { " ", { link = "DiagnosticWarning" }},
    },
  },
}
