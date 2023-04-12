local function tab_jump()
  return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
end

local function change_choice()
  return require("luasnip").choice_active() and "<Plug>luasnip-next-choice" or "<C-e>"
end

-- stylua: ignore start
local keys = {
  -- jump by tab
  { "<tab>", tab_jump, expr = true, mode = "i", },
  { "<tab>", function() require("luasnip").jump(1) end, mode = "s", },
  { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" }, },

  -- jump by <C-f|b>
  { "<C-f>", function() require("luasnip").jump(1) end, mode = { "i", "s" }, },
  { "<C-b>", function() require("luasnip").jump(-1) end, mode = { "i", "s" }, },

  -- choices
  { "<C-e>", change_choice, expr = true, mode = { "i", "s"} },
}
-- stylua: ignore end

return {
  "L3MON4D3/LuaSnip",
  version = "v1.*",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
  },
  keys = keys,
}
