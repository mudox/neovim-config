-- vim: fdm=marker fmr=〈,〉

-- Keys 〈

local function change_choice()
  return require("luasnip").choice_active() and "<Plug>luasnip-next-choice" or "<C-e>"
end

local function select_choice()
  if require("luasnip").choice_active() then
    require("luasnip.extras.select_choice")()
  end
end

local function edit_snippet()
  local my_pattern = vim.pesc("/Users/mudox/Git/neovim-config/luasnippets")
  local friendly_pattern = vim.pesc("/Users/mudox/.local/share/nvim/lazy/friendly-snippets/snippets")

  require("luasnip.loaders").edit_snippet_files {
    format = function(file, _)
      return file:gsub(my_pattern, "[MY] "):gsub(friendly_pattern, "[FRIENDLY] ")
    end,

    edit = function(file)
      vim.cmd("vsplit " .. file)
    end,

    extend = function(ft, _)
      local my_file = ("/Users/mudox/Git/neovim-config/luasnippets/%s.lua"):format(ft)
      if vim.fn.filereadable(my_file) == 0 then
        return {
          {
            ("[NEW] %s.lua"):format(ft),
            ("%s/%s.lua"):format("/Users/mudox/Git/neovim-config/luasnippets", ft),
          },
        }
      else
        return {}
      end
    end,
  }
end

-- stylua: ignore
local keys = {
  -- expand & juamp
  { "<C-f>",      function() require("luasnip").expand_or_jump() end,                mode =  "i",          desc =  "[LuaSnip] Expand or jump to next placeholder" },
  { "<C-f>",      function() require("luasnip").jump(1) end,                         mode =  { "v", "s" }, desc =  "[LuaSnip] Jump to next placeholder" },
  { "<C-b>",      function() require("luasnip").jump(-1) end,                        mode =  { "i", "s" }, desc =  "[LuaSnip] Jump to next placeholder" },

  -- choices
  { "<C-e>",      change_choice, expr = true,                                        mode =  { "i", "s" }, desc =  "[LuaSnip] Change choice" },
  { "<C-c>",      select_choice,                                                     mode =  { "i", "s" }, desc =  "[LuaSnip] Select choice" },


  -- edit
  { "<leader>es", edit_snippet,                                                                            desc =  "[LuaSnip] Edit snippet" },

  -- on the fly snippet
  { "<C-o>",      [["oc<Cmd>lua require("luasnip.extras.otf").on_the_fly("o")<Cr>]], mode =  "v",          desc =  "[LuaSnip] On-The-Fly snippet" },
  { "<C-o>",      function() require("luasnip.extras.otf").on_the_fly("o") end,      mode =  "i",          desc =  "[LuaSnip] On-The-Fly snippet" },
}

-- Keys 〉

local function opts(o)
  local t = require("luasnip.util.types")

  o.enable_autosnippets = true -- performance alert

  o.history = true

  o.update_events = "TextChanged, TextChangedI"
  o.region_check_events = "CursorMoved, CursorHold, InsertLeave"
  o.delete_check_events = "TextChanged, InsertLeave"

  o.store_selection_keys = "<C-f>"

  o.ext_opts = {
    [t.choiceNode] = {
      active = {
        virt_text = { { " ", "@symbol" } },
      },
    },
    [t.insertNode] = {
      active = {
        virt_text = { { "󰴓 ", "@field" } },
      },
    },
  }
end

local function config(_, o)
  require("luasnip").setup(o)

  require("luasnip.loaders.from_lua").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()
end

return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "honza/vim-snippets",
  },
  opts = opts,
  keys = keys,
  config = config,
}
