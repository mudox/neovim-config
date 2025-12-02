local op = {
  name = "TreeSJ",
  left = function()
    require("treesj").split()
  end,
  right = function()
    require("treesj").join()
  end,
}

-- stylua: ignore
local keys = {
  { "<Bslash>J",  X.arrows.left(op),  desc = '[TreeSJ] Split'  },
  { "<Bslash>j",  X.arrows.right(op), desc = '[TreeSJ] Join'   },
  { "<Bslash><Bslash>", function() require('treesj').toggle() end, desc = '[TreeSJ] Toggle' },
}

local function opts()
  return {
    use_default_keymaps = false,
  }
end

return {
  "Wansmer/treesj",
  cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
  keys = keys,
  opts = opts,
}
