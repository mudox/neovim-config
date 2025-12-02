local function opts()
  -- builtin mappings
  local mappings = {
    "angular",
    "golang",
  }

  return {
    mappings = mappings,
    style = {
      border = "single",
    },
  }
end

-- stylua: ignore
local keys = {
  -- { K.p"eo", "<Cmd>OtherVSplit<Cr>", desc = "[Other] VSplit" },
  { K.p"eo", "<Cmd>Other<Cr>",       desc = "[Other] Edit"   },
}

return {
  "rgroli/other.nvim",
  cmd = {
    "Other",
    "OtherTabNew",
    "OtherSplit",
    "OtherVSplit",
    "OtherClear",
  },
  keys = keys,
  opts = opts,
  main = "other-nvim",
}
