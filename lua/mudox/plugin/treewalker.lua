local function keys()
  local op = X.arrows.excmd(
    "treewalker",
    "<Cmd>Treewalker Left<Cr>zMzv",
    "<Cmd>Treewalker Right<Cr>zMzv",
    "<Cmd>Treewalker Up<Cr>zMzv",
    "<Cmd>Treewalker Down<Cr>zMzv"
  )

  -- stylua: ignore
  return {
    { "<C-Up>",    X.arrows.up(op),    desc = "[treewalker] parent" },
    { "<C-Down>",  X.arrows.down(op),  desc = "[treewalker] child"  },
    { "<C-Left>",  X.arrows.left(op),  desc = "[treewalker] prev"   },
    { "<C-Right>", X.arrows.right(op), desc = "[treewalker] next"   },
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
