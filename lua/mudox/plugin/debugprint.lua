local function k(text)
  return "<leader>ed" .. text
end

return {
  "andrewferrier/debugprint.nvim",
  dependencies = {
    "echasnovski/mini.nvim", -- Needed for :ToggleCommentDebugPrints (not needed for NeoVim 0.10+)
  },
  -- stylua: ignore
  keys = {
    { k"v",     desc = "Variable below"   },
    { k"V",     desc = "Variable above"   },

    { k"<Cr>",  desc = "Prompt below"     },
    { k"<S-Cr", desc = "Prompt above"     },

    { k"p",     desc = "Plain below"      },
    { k"P",     desc = "Plain above"      },

    { k"o",     desc = "Textobject below" },
    { k"O",     desc = "Textobject above" },

    { k"/",     desc = "Toggle comment"   },
    { k"<Bs>",  desc = "Delete"           },
  },
  cmd = {
    "ToggleCommentDebugPrints",
    "DeleteDebugPrints",
  },
  opts = {
    keymaps = {
      -- stylua: ignore
      normal = {
        plain_below                 = k"p",
        plain_above                 = k"P",
        variable_below              = k"v",
        variable_above              = k"V",
        variable_below_alwaysprompt = k"<Cr>",
        variable_above_alwaysprompt = k"<S-Cr>",
        textobj_below               = k"o",
        textobj_above               = k"O",
        toggle_comment_debug_prints = k"/",
        delete_debug_prints         = k"<Bs>",
      },
      -- stylua: ignore
      visual = {
        variable_below = k"v",
        variable_above = k"V",
      },
    },
  },
}
