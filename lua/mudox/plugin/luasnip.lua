-- vim: fdm=marker fmr=〈,〉

-- Keys 〈

local function change_choice()
  return require("luasnip").choice_active() and "<Plug>luasnip-next-choice" or "<C-e>"
end

local function select_choice()
  require("luasnip.extras.select_choice")()
end

local function edit_snippet()
  require("luasnip.loaders").edit_snippet_files {
    format = function(file, source_name)
      return file
        :gsub("/Users/mudox/Git/neovim%-config/luasnippets", "[MY]")
        :gsub("/Users/mudox/.local/share/nvim/lazy/friendly%-snippets/snippets", "[FRIENDLY]")
    end,
    edit = function(file)
      vim.cmd("vnew " .. file)
    end,
  }
end

-- stylua: ignore start
local keys = {
  -- jump by tab
  -- { "<tab>", smart_tab, expr = true, mode = "i" },
  -- { "<tab>", function() require("luasnip").jump(1) end, mode = "s", },
  -- { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" }, },

  -- expand & juamp
  { "<C-f>", function() require("luasnip").expand_or_jump() end, mode = { "i", "s" }, },
  { "<C-b>", function() require("luasnip").jump(-1) end, mode = { "i", "s" }, },

  -- choices
  { "<C-e>", change_choice, expr = true, mode = { "i", "s" }, desc = "Change Choice" },
  { "<C-S-s>", select_choice, expr = true, mode = { "i", "s" }, desc = "Select Choice" },

  -- edit
  { "<leader>es", edit_snippet, desc = "Edit Snippet" },


  -- on the fly snippet
  { "<C-o>", [["oc<Cmd>lua require("luasnip.extras.otf").on_the_fly("o")<Cr>]], mode = "v", desc = "On-The-Fly Snippet" },
  { "<C-o>", function() require("luasnip.extras.otf").on_the_fly("o") end, mode = "i", desc = "On-The-Fly Snippet" },

  -- log
  { '<space>v', }
}
-- stylua: ignore end

-- Keys 〉

local function config(_, opts)
  require("luasnip").setup(opts)

  require("luasnip.loaders.from_lua").lazy_load()
  require("luasnip.loaders.from_vscode").lazy_load()
  require("luasnip.loaders.from_snipmate").lazy_load()
end

local opts = {
  history = true,
  delete_check_events = "TextChanged",
  store_selection_keys = "<C-f>",
}

return {
  "L3MON4D3/LuaSnip",
  version = "v1.*",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "honza/vim-snippets",
  },
  opts = opts,
  keys = keys,
  config = config,
}
