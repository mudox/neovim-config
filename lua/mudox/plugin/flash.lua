local opts = {
  jump = {
    autojump = true,
  },
  modes = {
    char = {
      -- `,` conflict with `<leader>` settings and `which-key.nvim`
      keys = { "f", "F", "t", "T" },
    },
  },
}

local keys = {
  {
    "s",
    mode = { "n", "x", "o" },
    function()
      require("flash").jump()
    end,
    desc = "Flash",
  },
  {
    "S",
    mode = { "n", "x", "o" },
    function()
      require("flash").treesitter()
    end,
    desc = "Flash Treesitter",
  },
  {
    "r",
    mode = "o",
    function()
      require("flash").remote()
    end,
    desc = "Remote Flash",
  },
  {
    "v",
    mode = { "o", "x" },
    function()
      require("flash").treesitter_search()
    end,
    desc = "Flash Treesitter Search",
  },
  {
    "<C-s>",
    mode = { "c" },
    function()
      require("flash").toggle()
    end,
    desc = "Toggle Flash Search",
  },
}

return {
  "folke/flash.nvim",
  -- init = init,
  event = "VeryLazy",
  keys = keys,
  opts = opts,
}
