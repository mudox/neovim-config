local function swap_up()
  vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
  return "g@l"
end

local function swap_down()
  vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
  return "g@l"
end

local function swap_next()
  vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
  return "g@l"
end

local function swap_prev()
  vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
  return "g@l"
end

-- stylua: ignore
local keys = {
  { "vU", swap_up,             "Swap up",              expr = true },
  { "vD", swap_down,           "Swap down",            expr = true },
  { "vn", "SwapCurrentNodeNextNormal",   "Swap next",            expr = true },
  { "vp", swap_prev,           "Swap prev",            expr = true },

  { "vM", "SelectMasterNode",  "Select master node"                },
  { "vm", "SelectCurrentNode", "Select current node"               },
}

keys = require("mudox.util.keymap").lazy_keys(keys, {
  cmd_fmt = "<Cmd>STS%s<Cr>",
  desc_prefix = "STS",
})

return {
  "ziontee113/syntax-tree-surfer",
  keys = keys,
  cond = false,
}
