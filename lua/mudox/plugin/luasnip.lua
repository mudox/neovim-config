-- vim: fml& fdn& fdm=marker fmr=〈,〉

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
  -- expand
  -- expand by <tab> in blink.cmp
  -- { "<M-n>",      function() require("luasnip").expand() end, mode = "i",          desc =  "[LuaSnip] Expand or jump"               },

  -- jump
  { "<M-n>", function() require("luasnip").jump(1) end,  desc = "[LuaSnip] Jump to next placeholder",     mode = {'i', 's'} },
  { "<M-p>", function() require("luasnip").jump(-1) end, desc = "[LuaSnip] Jump to previous placeholder", mode = {'i', 's'} },

  -- choices
  { "<C-e>", change_choice, expr = true,                 desc = "[LuaSnip] Change choice",                mode = {'i', 's'} },
  { "<C-c>", select_choice,                              desc = "[LuaSnip] Select choice",                mode = {'i', 's'} },

  -- edit
  { K.p"es", edit_snippet,                               desc = "[LuaSnip] Edit snippet",                                   },

  -- on the fly snippet
  -- { "<C-o>",      [["oc<Cmd>lua require("luasnip.extras.otf").on_the_fly("o")<Cr>]], mode =  "v",          desc =  "[LuaSnip] On-The-Fly snippet" },
  -- { "<C-o>",      function() require("luasnip.extras.otf").on_the_fly("o") end,      mode =  "i",          desc =  "[LuaSnip] On-The-Fly snippet" },
}

-- Keys 〉

local function opts(_, o)
  local t = require("luasnip.util.types")

  o.enable_autosnippets = false -- impact performance

  o.history = true

  o.update_events = "TextChanged, TextChangedI"
  o.region_check_events = "CursorMoved, CursorHold, InsertLeave"
  o.delete_check_events = "TextChanged, InsertLeave"

  o.store_selection_keys = "<Tab>"

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
