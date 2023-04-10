local function tab_jump()
  return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
end

-- stylua: ignore start
local keys = {
  -- jump by tab
  { "<tab>", tab_jump, expr = true, silent = true, mode = "i", },
  { "<tab>", function() require("luasnip").jump(1) end, mode = "s", },
  { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" }, },

  -- jump by <C-f|b>
  { "<C-f>", function() require("luasnip").jump(1) end, mode = { "i", "s" }, },
  { "<C-b>", function() require("luasnip").jump(-1) end, mode = { "i", "s" }, },
}
-- stylua: ignore end

return {
  "L3MON4D3/LuaSnip",
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
