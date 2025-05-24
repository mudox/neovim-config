local opts = {
  init = function()
    require("hover.providers.lsp")
    require("hover.providers.gh")
    require("hover.providers.gh_user")
    require("hover.providers.jira")
    require("hover.providers.dap")
    require("hover.providers.diagnostic")
    require("hover.providers.man")
    require("hover.providers.dictionary")
    require("hover.providers.highlight")
  end,
  preview_opts = {
    border = "none",
  },
  preview_window = true,
}

-- stylua: ignore
local keys = {
  { "K",           function() require("hover").hover() end,                  desc = "[Hover] Show"   },
  { "<leader>vk",  function() require("hover").hover_select() end,           desc = "[Hover] Select" },

  { "<C-S-Left>",  function() require("hover").hover_switch("previous") end, desc = "[Hover] Prev"   },
  { "<C-S-Right>", function() require("hover").hover_switch("next") end,     desc = "[Hover] Next"   },

  { "<MouseMove>", function() require("hover").hover_mouse() end,            desc = "[Hover] Mouse"  },
}

local function config()
  require("hover").setup(opts)
  -- custom providers
end

return {
  "lewis6991/hover.nvim",
  keys = keys,
  config = config,
}
