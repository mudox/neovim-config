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
    backdrop = false, -- improve drawing speed
  },
  jump = {
    autojump = true,
    nohlsearch = false,
  },
  prompt = {
    prefix = { { " ", "FlashPromptIcon" } },
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
  { "s",        mode = { "o", "x", "n" }, function() require("flash").jump() end,              "Jump",                   },

  -- expand selection
  { "<Space>",  mode = { "o", "x" },      function() require("flash").treesitter() end,        "Expand selection",       },

  -- jump + motion
  { "<Bslash>", mode = { "o" },           function() require("flash").remote() end,            "Remote mode",            },
  -- jump + expand selection
  { "/",        mode = { "o" },           function() require("flash").treesitter_search() end, "Remote treesitter mode", },

  -- search
  { "<C-s>",    mode = { "c" },           function() require("flash").toggle() end,            "Toggle flash search",    },
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
