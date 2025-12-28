local opts = {
  -- default options for modes
  search = {
    multi_window = true,
  },
  label = {
    current = true, -- for folded line
    after = false,
    before = true,
  },
  highlight = {
    matches = false,
    backdrop = false, -- improve drawing speed
  },
  jump = {
    autojump = true,
    nohlsearch = true,
  },
  prompt = {
    prefix = { { "󰉁 ", "FlashPromptIcon" } },
  },

  modes = {
    search = {
      enabled = false,
      jump = {
        autojump = false,
      },
    },
    char = {
      -- `,`, `;` are used as prefixes
      keys = { "t", "T" },
      jump_labels = true,
      char_actions = function(motion)
        return {
          [motion:lower()] = "right",
          [motion:upper()] = "left",
        }
      end,
    },
  },
}

local function goto_empty_line()
  require("flash").jump {
    search = { mode = "search", max_length = 0 },
    highlight = { backdrop = false, matches = false },
    pattern = "^\\s*$",
  }
end

-- stylua: ignore
local keys = {
  -- jump
  { "f",        function() require("flash").jump() end,              "[flash] jump",                   mode = { "o",   "x",   "n" }, },
  { "g<Space>", goto_empty_line,                                     "[flash] empty line",             mode = { "o",   "x",   "n" }, },

  -- expantion
  { ";",        function() require("flash").treesitter() end,        "[flash] expand selection",       mode = { "o",   "x"        }, },

  -- search mode
  { "<C-,>",    function() require("flash").toggle() end,            "[flash] toggle flash search",    mode = { "c"               }, },

  -- remote motion
  { [[\]],      function() require("flash").remote() end,            "[flash] remote mode",            mode = { "o"               }, },
  -- remote expansion
  { [[/]],      function() require("flash").treesitter_search() end, "[flash] remote treesitter mode", mode = { "o"               }, },
}

vim.list_extend(keys, { "t", "T" })

return {
  "folke/flash.nvim",
  keys = keys,
  opts = opts,
}
