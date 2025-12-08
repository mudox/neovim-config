local function keys()
  local function walk(dir)
    return function()
      vim.cmd("Treewalker " .. dir)
    end
  end
  local walk_op = {
    name = "[treewalker] goto",
    left = walk("Left"),
    right = walk("Right"),
    up = walk("Up"),
    down = walk("Down"),
  }

  local function swap(dir)
    return function()
      vim.cmd("Treewalker Swap" .. dir)
    end
  end
  local swap_op = {
    name = "[treewalker] swap",
    left = swap("Left"),
    right = swap("Right"),
    up = swap("Up"),
    down = swap("Down"),
  }

  -- stylua: ignore
  return {
    { "gH", X.arrows.left(walk_op),  desc = "[treewalker] prev"   },
    { "gL", X.arrows.right(walk_op), desc = "[treewalker] next"   },
    { "gK", X.arrows.up(walk_op),    desc = "[treewalker] parent" },
    { "gJ", X.arrows.down(walk_op),  desc = "[treewalker] child"  },

    { "<M-[>", X.arrows.left(swap_op),                   desc = "[treewalker] swap prev"      },
    { "<M-]>", X.arrows.right(swap_op),                  desc = "[treewalker] swap next"      },
    { "\\x",   function() V.last_arrow_op = swap_op end, desc = "[treewalker] start swapping" },
  }
end
return {
  "aaronik/treewalker.nvim",
  cmd = "Treewalker",
  keys = keys,
  opts = {
    highlight = true,
  },
}
