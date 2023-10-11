local select = {
  enable = true,
  lookahead = true,
  keymaps = {
    -- https://github.com/josean-dev/dev-environment-files/blob/1bcf8bfd532c1fe549798a0f4a3ab351970de3d3/.config/nvim/lua/josean/plugins/nvim-treesitter-text-objects.lua
    ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
    ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
    ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
    ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

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
    ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
    ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

    -- function definition
    ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
    ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

    -- class
    ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
    ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
  },
}

local move = {
  enable = true,
  set_jumps = true, -- whether to set jumps in the jumplist
  goto_next_start = {
    ["]f"] = { query = "@call.outer", desc = "Next function call start" },
    ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
    ["]r"] = { query = "@function.outer", desc = "Next method/function def start" }, -- 'r' for routine
    ["]c"] = { query = "@class.outer", desc = "Next class start" },
    ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
    ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

    -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
    -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
    ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
    ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
  },
  goto_next_end = {
    ["]F"] = { query = "@call.outer", desc = "Next function call end" },
    ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
    ["]R"] = { query = "@function.outer", desc = "Next method/function def end" },
    ["]C"] = { query = "@class.outer", desc = "Next class end" },
    ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
    ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
  },
  goto_previous_start = {
    ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
    ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
    ["[r"] = { query = "@function.outer", desc = "Prev method/function def start" },
    ["[c"] = { query = "@class.outer", desc = "Prev class start" },
    ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
    ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
  },
  goto_previous_end = {
    ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
    ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
    ["[R"] = { query = "@function.outer", desc = "Prev method/function def end" },
    ["[C"] = { query = "@class.outer", desc = "Prev class end" },
    ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
    ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
  },
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
