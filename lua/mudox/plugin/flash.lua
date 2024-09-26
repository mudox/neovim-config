local opts = {
  search = {
    multi_window = true,
  },
  label = {
    current = true, -- for foldline
    after = false,
    before = true,
  },
  highlight = {
    matches = false,
    backdrop = false, -- improve drawing speed
  },
  jump = {
    autojump = true,
    nohlsearch = false,
  },
  prompt = {
    prefix = { { "󰉁 ", "FlashPromptIcon" } },
  },

  modes = {
    search = {
      jump = {
        autojump = false,
      },
    },

    char = {
      -- `,` conflict with `<leader>` settings and `which-key.nvim`
      keys = { "f", "F", "t", "T" },
      jump_labels = true,
      char_actions = function(motion)
        return {
          [";"] = "right",
          [","] = "left",
          [motion:lower()] = "right",
          [motion:upper()] = "left",
        }
      end,
    },
  },
}

-- stylua: ignore
local keys = {
  -- jump
  { "s",        function() require("flash").jump() end,              "Jump",                   mode = { "o",   "x",   "n" }, },

  -- expand selection
  { "<Space>",  function() require("flash").treesitter() end,        "Expand selection",       mode = { "o",   "x"        }, },

  -- jump + motion
  { "<Bslash>", function() require("flash").remote() end,            "Remote mode",            mode = { "o"               }, },
  -- jump + expand selection
  { "/",        function() require("flash").treesitter_search() end, "Remote treesitter mode", mode = { "o"               }, },

  -- search
  { "<C-s>",    function() require("flash").toggle() end,            "Toggle flash search",    mode = { "c"               }, },
}

keys = K.lazy_keys(keys, {
  desc_prefix = "Flash",
})

vim.list_extend(keys, { "f", "F", "t", "T" })

return {
  "folke/flash.nvim",
  keys = keys,
  opts = opts,
}
