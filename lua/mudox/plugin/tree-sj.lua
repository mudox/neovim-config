local op = {
  name = "join split (j)",
  next = function()
    require("treesj").split()
  end,
  prev = function()
    require("treesj").join()
  end,
}

-- stylua: ignore
local keys = {
  { "<Bslash>J",  X.dirop.wrap(op, "next"),  desc = '[TreeSJ] Split'  },
  { "<Bslash>j",  X.dirop.wrap(op, "prev"),  desc = '[TreeSJ] Join'   },
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
