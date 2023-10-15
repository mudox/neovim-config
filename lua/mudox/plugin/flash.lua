local opts = {
  search = {
    multi_window = true,
  },
  label = {
    current = false, -- use <Cr> to jump to 1st match
    after = false,
    before = true,
  },
  highlight = {
    backdrop = false, -- improve drawing speed
  },
  jump = {
    autojump = false,
    nohlsearch = true,
  },
  prompt = {
    prefix = { { " ", "FlashPromptIcon" } },
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
          [motion:upper()] = "left",
        }
      end,
    },
  },
}

local function f()
  return require("flash")
end

-- stylua: ignore
local keys = {
  -- jump
  { "s",       mode = { "n", "x", "o" }, function() f().jump() end,              "Jump", },

  -- expand selection
  { "v",       mode = { "x", "o" },      function() f().treesitter() end,        "Expand selection", },
  { "<Space>", mode = { "x", "o" },      function() f().treesitter() end,        "Expand selection", },

  -- jump and ...
  { "\\",      mode = { "o" },           function() f().remote() end,            "Remote mode", },
  -- jump and then expand selection
  { "/",       mode = { "o" },           function() f().treesitter_search() end, "Remote treesitter mode", },

  -- search
  { "<C-s>",   mode = { "c" },           function() f().toggle() end,            "Toggle flash search", },
}

keys = require("mudox.util.keymap").lazy_keys(keys, {
  desc_prefix = "Flash",
})

return {
  "folke/flash.nvim",
  keys = keys,
  opts = opts,
}
