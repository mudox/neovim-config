-- DO NOT use l, r in omap or xmap which conflict with moving keymaps

-- :  󰅂 key-value pair
-- =  󰅂 assignment
-- a  󰅂 argument / parameter
-- c  󰅂 class
-- f  󰅂 function
-- ^  󰅂 condition
-- k  󰅂 function call
-- @  󰅂 loop
-- s  󰅂 scope
-- /  󰅂 comment

local function setup_select()
  require("nvim-treesitter-textobjects").setup {
    select = {
      lookahead = true,
    },
  }

  -- stylua: ignore
  local keymaps = {
    -- assignment (`lhs = rhs`)
    ["a="] = { query = "@assignment.outer",  desc = "Outer of an assignment"         },
    ["i="] = { query = "@assignment.inner",  desc = "Inner of an assignment"         },
    [",="] = { query = "@assignment.lhs",    desc = "Left of an assignment"          },
    [".="] = { query = "@assignment.rhs",    desc = "Right of an assignment"         },

    -- pairs (`key: value`) in languages like javascript, typescript ...
    ["a:"] = { query = "@property.outer",    desc = "Outer of an object property"    },
    ["i:"] = { query = "@property.inner",    desc = "Inner of an object property"    },
    [",:"] = { query = "@property.lhs",      desc = "Left of an object property"     },
    [".:"] = { query = "@property.rhs",      desc = "Right of an object property"    },

    -- argument / parameter
    ["aa"] = { query = "@parameter.outer",   desc = "Outer of a parameter/argument"  },
    ["ia"] = { query = "@parameter.inner",   desc = "Inner of a parameter/argument"  },

    -- condition
    ["a^"] = { query = "@conditional.outer", desc = "Outer of a condition"         },
    ["i^"] = { query = "@conditional.inner", desc = "Inner of a condition"         },

    -- loop
    ["a@"] = { query = "@loop.outer",        desc = "Outer of a loop"                },
    ["i@"] = { query = "@loop.inner",        desc = "Inner of a loop"                },

    -- function call
    ["ak"] = { query = "@call.outer",        desc = "Outer of a function call"       },
    ["ik"] = { query = "@call.inner",        desc = "Inner of a function call"       },

    -- function definition
    ["af"] = { query = "@function.outer",    desc = "Outer of a function definition" },
    ["if"] = { query = "@function.inner",    desc = "Inner of a function definition" },

    -- class
    ["ac"] = { query = "@class.outer",       desc = "Outer of a class"               },
    ["ic"] = { query = "@class.inner",       desc = "Inner of a class"               },

    -- comment
    ["a/"] = { query = "@comment.outer",     desc = "Outer of a comment"             },
    ["i/"] = { query = "@comment.inner",     desc = "Inner of a comment"             },
  }

  for key, v in pairs(keymaps) do
    vim.keymap.set({ "x", "o" }, key, function()
      require("nvim-treesitter-textobjects.select").select_textobject(v.query, v.origin or "textobjects")
    end, { desc = v.desc })
  end
end

local function setup_jump()
  require("nvim-treesitter-textobjects").setup {
    move = {
      -- whether to set jumps in the jumplist
      set_jumps = true,
    },
  }

  -- stylua: ignore
  local move = {
    ["f"] = { query = "@function.outer",                       name = "function"  },
    ["k"] = { query = "@call.outer",                           name = "call"      },

    ["^"] = { query = "@conditional.outer",                    name = "condition" },
    ["@"] = { query = "@loop.outer",                           name = "loop"      },

    ["s"] = { query = "@scope",             origin = "locals", name = "scope"     },
    --["󰅂c"] = { query = "@class.outer",       desc = "Class start" },
  }

  for key, v in pairs(move) do
    local start_op = {
      name = v.name,
      left = function()
        require("nvim-treesitter-textobjects.move").goto_previous_start(v.query, v.origin or "textobjects")
      end,
      right = function()
        require("nvim-treesitter-textobjects.move").goto_next_start(v.query, v.origin or "textobjects")
      end,
    }

    vim.keymap.set({ "n", "x", "o" }, "][" .. key, X.arrows.right(start_op), { desc = start_op.name })
    vim.keymap.set({ "n", "x", "o" }, "[[" .. key, X.arrows.left(start_op), { desc = start_op.name })

    local end_op = {
      name = v.name,
      left = function()
        require("nvim-treesitter-textobjects.move").goto_previous_end(v.query, v.origin or "textobjects")
      end,
      right = function()
        require("nvim-treesitter-textobjects.move").goto_next_end(v.query, v.origin or "textobjects")
      end,
    }

    vim.keymap.set({ "n", "x", "o" }, "]]" .. key, X.arrows.right(end_op), { desc = end_op.name })
    vim.keymap.set({ "n", "x", "o" }, "[]" .. key, X.arrows.left(end_op), { desc = end_op.name })
  end
end

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = { "BufReadPre", "BufNewFile" },
  branch = "main",
  config = function()
    setup_select()
    setup_jump()
    -- use iswap.nvim for swap
  end,
}
