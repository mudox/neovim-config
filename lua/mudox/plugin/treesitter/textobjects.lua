-- DO NOT use l, r in omap or xmap which conflict with moving keymaps

-- :  󰅂 key-value pair
-- =  󰅂 assignment
-- a  󰅂 argument / parameter
-- c  󰅂 class
-- f  󰅂 function
-- i  󰅂 condition
-- k  󰅂 function call
-- @  󰅂 loop
-- s  󰅂 scope
-- /  󰅂 comment

-- stylua: ignore start

local select = {
  enable = true,
  lookahead = true,
}

select.keymaps = {
  -- assignment (`lhs = rhs`)
  ["a="] = { query = "@assignment.outer",  desc = "Outer of an assignment" },
  ["i="] = { query = "@assignment.inner",  desc = "Inner of an assignment" },
  [",="] = { query = "@assignment.lhs",    desc = "Left of an assignment" },
  [".="] = { query = "@assignment.rhs",    desc = "Right of an assignment" },

  -- pairs (`key: value`) in languages like javascript, typescript ...
  ["a:"] = { query = "@property.outer",    desc = "Outer of an object property" },
  ["i:"] = { query = "@property.inner",    desc = "Inner of an object property" },
  [",:"] = { query = "@property.lhs",      desc = "Left of an object property" },
  [".:"] = { query = "@property.rhs",      desc = "Right of an object property" },

  -- argument / parameter
  ["aa"] = { query = "@parameter.outer",   desc = "Outer of a parameter/argument" },
  ["ia"] = { query = "@parameter.inner",   desc = "Inner of a parameter/argument" },

  -- condition
  ["ai"] = { query = "@conditional.outer", desc = "Outer of a conditional" },
  ["ii"] = { query = "@conditional.inner", desc = "Inner of a conditional" },

  -- loop
  ["a@"] = { query = "@loop.outer",        desc = "Outer of a loop" },
  ["i@"] = { query = "@loop.inner",        desc = "Inner of a loop" },

  -- function call
  ["ak"] = { query = "@call.outer",        desc = "Outer of a function call" },
  ["ik"] = { query = "@call.inner",        desc = "Inner of a function call" },

  -- function definition
  ["af"] = { query = "@function.outer",    desc = "Outer of a function definition" },
  ["if"] = { query = "@function.inner",    desc = "Inner of a function definition" },

  -- class
  ["ac"] = { query = "@class.outer",       desc = "Outer of a class" },
  ["ic"] = { query = "@class.inner",       desc = "Inner of a class" },

  -- comment
  ["a/"] = { query = "@comment.outer",     desc = "Outer of a comment" },
  ["i/"] = { query = "@comment.inner",     desc = "Inner of a comment" },
}

local move = {
  enable = true,
  set_jumps = true, -- whether to set jumps in the jumplist
}

move.goto_next_start = {
  ["󰅂k"] = { query = "@call.outer",        desc = "Next function call start" },
  ["󰅂f"] = { query = "@function.outer",    desc = "Next method/function def start" },
  -- ["󰅂c"] = { query = "@class.outer",       desc = "Next class start" },
  ["󰅂i"] = { query = "@conditional.outer", desc = "Next conditional start" },
  ["󰅂@"] = { query = "@loop.outer",        desc = "Next loop start" },
  ["󰅂s"] = { query = "@scope",             desc = "Next scope",     query_group  = "locals" },
}

move.goto_next_end = {
  ["󰅂K"] = { query = "@call.outer",        desc = "Next function call end" },
  ["󰅂F"] = { query = "@function.outer",    desc = "Next method/function def end" },
  -- ["󰅂C"] = { query = "@class.outer",       desc = "Next class end" },
  ["󰅂I"] = { query = "@conditional.outer", desc = "Next conditional end" },
  ["󰅂L"] = { query = "@loop.outer",        desc = "Next loop end" },
  ["󰅂S"] = { query = "@scope",             desc = "Next scope",     query_group  = "locals" },
}

move.goto_previous_start = {
  ["󰅁k"] = { query = "@call.outer",        desc = "Previous function call start" },
  ["󰅁f"] = { query = "@function.outer",    desc = "Previous method/function def start" },
  -- ["󰅁c"] = { query = "@class.outer",       desc = "Previous class start" },
  ["󰅁i"] = { query = "@conditional.outer", desc = "Previous conditional start" },
  ["󰅁@"] = { query = "@loop.outer",        desc = "Previous loop start" },
  ["󰅁s"] = { query = "@scope",             desc = "Previous scope", query_group  = "locals" },
}

move.goto_previous_end = {
  ["󰅁K"] = { query = "@call.outer",        desc = "Previous function call end" },
  ["󰅁F"] = { query = "@function.outer",    desc = "Previous function def end" },
  -- ["󰅁C"] = { query = "@class.outer",       desc = "Previous class end" },
  ["󰅁I"] = { query = "@conditional.outer", desc = "Previous conditional end" },
  ["󰅁L"] = { query = "@loop.outer",        desc = "Previous loop end" },
  ["󰅁S"] = { query = "@scope",             desc = "Previous scope", query_group  = "locals" },
}

-- stylua: ignore end

local function setup_keymaps()
  local function d(name, postfix)
    -- stylua: ignore
    return {
      name = name,
      next = function() vim.cmd.normal("󰅂" .. postfix) end,
      prev = function() vim.cmd.normal("󰅁" .. postfix) end,
    }
  end

  local function next(name, postfix)
    return X.dirop.wrap(d(name, postfix), "next")
  end

  local function prev(name, postfix)
    return X.dirop.wrap(d(name, postfix), "prev")
  end

  local keys = { ["]"] = {}, ["["] = {} }

  for k, v in pairs(move.goto_next_start) do
    local name = v.desc:sub(6)
    local postfix = k:sub(-1)
    keys["]"][postfix] = { next(name, postfix), v.desc }
  end

  for k, v in pairs(move.goto_previous_start) do
    local name = v.desc:sub(9)
    local postfix = k:sub(-1)
    keys["["][postfix] = { prev(name, postfix), v.desc }
  end

  for k, v in pairs(move.goto_next_end) do
    local name = v.desc:sub(6)
    local postfix = k:sub(-1)
    keys["]"][postfix] = { next(name, postfix), v.desc }
  end

  for k, v in pairs(move.goto_previous_end) do
    local name = v.desc:sub(9)
    local postfix = k:sub(-1)
    keys["["][postfix] = { prev(name, postfix), v.desc }
  end

  require("which-key").register(keys)
end

local config = function()
  ---@diagnostic disable-next-line: missing-fields
  require("nvim-treesitter.configs").setup {
    textobjects = {
      select = select,
      move = move,
      swap = { enable = false }, -- use iswap.nvim instead
    },
  }

  setup_keymaps()
end

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  event = { "BufReadPre", "BufNewFile" },
  config = config,
}
