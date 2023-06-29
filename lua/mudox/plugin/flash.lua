local opts = {
  jump = {
    autojump = true,
  },
  char = {
    keys = { "f", "F", "t", "T" },
  },
}

local function init()
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
      mode = { "n", "o", "x" },
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
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Flash Treesitter Search",
    },
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
  }

  for _, k in ipairs(keys) do
    vim.keymap.set(k.mode, k[1], k[2], {
      desc = k.desc,
    })
  end
end

return {
  "folke/flash.nvim",
  init = init,
  event = "VeryLazy",
  opts = opts,
}
