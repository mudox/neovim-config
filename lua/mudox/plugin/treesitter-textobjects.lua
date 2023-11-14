local select = {
  enable = true,
  lookahead = true,
  keymaps = {
    -- https://github.com/josean-dev/dev-environment-files/blob/1bcf8bfd532c1fe549798a0f4a3ab351970de3d3/.config/nvim/lua/josean/plugins/nvim-treesitter-text-objects.lua
    ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
    ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
    -- ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
    -- ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

    -- works for javascript/typescript files (custom capture I created in after/queries/ecma/textobjects.scm)
    -- ["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
    -- ["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
    -- ["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
    -- ["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

    -- argument / parameter
    ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
    ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

    -- condition
    ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
    ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

    -- loop
    ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
    ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

    -- function call
    ["ak"] = { query = "@call.outer", desc = "Select outer part of a function call" },
    ["ik"] = { query = "@call.inner", desc = "Select inner part of a function call" },

    -- function definition
    ["af"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
    ["if"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

    -- class
    ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
    ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
  },
}

local move = {
  enable = true,
  set_jumps = true, -- whether to set jumps in the jumplist
  -- stylua: ignore start
  goto_next_start = {
    ["󰅂f"] = { query = "@call.outer",        desc = "Next function call start" },
    ["󰅂r"] = { query = "@function.outer",    desc = "Next method/function def start" },
    ["󰅂c"] = { query = "@class.outer",       desc = "Next class start" },
    ["󰅂i"] = { query = "@conditional.outer", desc = "Next conditional start" },
    ["󰅂l"] = { query = "@loop.outer",        desc = "Next loop start" },
    ["󰅂s"] = { query = "@scope",             desc = "Next scope",     query_group  = "locals" },
  },
  goto_next_end = {
    ["󰅂F"] = { query = "@call.outer",        desc = "Next function call end" },
    ["󰅂R"] = { query = "@function.outer",    desc = "Next method/function def end" },
    ["󰅂C"] = { query = "@class.outer",       desc = "Next class end" },
    ["󰅂I"] = { query = "@conditional.outer", desc = "Next conditional end" },
    ["󰅂L"] = { query = "@loop.outer",        desc = "Next loop end" },
    ["󰅂S"] = { query = "@scope",             desc = "Next scope",     query_group  = "locals" },
  },
  goto_previous_start = {
    ["󰅁f"] = { query = "@call.outer",        desc = "Previous function call start" },
    ["󰅁r"] = { query = "@function.outer",    desc = "Previous method/function def start" },
    ["󰅁c"] = { query = "@class.outer",       desc = "Previous class start" },
    ["󰅁i"] = { query = "@conditional.outer", desc = "Previous conditional start" },
    ["󰅁l"] = { query = "@loop.outer",        desc = "Previous loop start" },
    ["󰅁s"] = { query = "@scope",             desc = "Previous scope", query_group  = "locals" },
  },
  goto_previous_end = {
    ["󰅁F"] = { query = "@call.outer",        desc = "Previous function call end" },
    ["󰅁R"] = { query = "@function.outer",    desc = "Previous method/function def end" },
    ["󰅁C"] = { query = "@class.outer",       desc = "Previous class end" },
    ["󰅁I"] = { query = "@conditional.outer", desc = "Previous conditional end" },
    ["󰅁L"] = { query = "@loop.outer",        desc = "Previous loop end" },
    ["󰅁S"] = { query = "@scope",             desc = "Previous scope", query_group  = "locals" },
  },
  -- stylua: ignore end
}

local config = function()
  ---@diagnostic disable-next-line: missing-fields
  require("nvim-treesitter.configs").setup {
    textobjects = {
      select = select,
      swap = { enable = false }, -- use iswap.nvim instead
      move = move,
    },
  }
end

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  config = config,
}
