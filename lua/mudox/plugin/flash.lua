local opts = {
  jump = {
    autojump = true,
  },
  modes = {
    char = {
      -- `,` conflict with `<leader>` settings and `which-key.nvim`
      keys = { "f", "F", "t", "T" },
      jump_labels = true,
      char_actions = function(motion)
        return {
          [";"] = "right",
          [","] = "left",
          [motion:lower()] = "right",
          [motion:upper()] = "next",
        }
      end,
    },
  },
}

local keys = {
  -- jump
  {
    "s",
    mode = { "n", "x", "o" },
    function()
      require("flash").jump()
    end,
    desc = "[Flash] Jump",
  },

  -- epxand selection
  {
    "vv",
    mode = { "n" },
    function()
      require("flash").treesitter()
    end,
    desc = "[Flash] Expand selection",
  },
  {
    "v<Space>",
    mode = { "n" },
    function()
      require("flash").treesitter()
    end,
    desc = "[Flash] Expand selection",
  },
  {
    "v",
    mode = { "x", "o" },
    function()
      require("flash").treesitter()
    end,
    desc = "[Flash] Expand selection",
  },
  {
    "<Space>",
    mode = { "x", "o" },
    function()
      require("flash").treesitter()
    end,
    desc = "[Flash] Expand selection",
  },

  -- jump and ...
  {
    "r",
    mode = "o",
    function()
      require("flash").remote()
    end,
    desc = "[Flash] Remote mdoe",
  },

  -- jump and then expand selection
  {
    "R",
    mode = { "x", "o" },
    function()
      require("flash").treesitter_search()
    end,
    desc = "[Flash] Treesitter search",
  },

  -- search
  {
    "<C-s>",
    mode = { "c" },
    function()
      require("flash").toggle()
    end,
    desc = "[Flash] Toggle flash search",
  },
}

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = keys,
  opts = opts,
}
