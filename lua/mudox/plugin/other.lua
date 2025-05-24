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
  { "<leader>eo", "<Cmd>OtherVSplit<Cr>", desc = "[Other] VSplit" },
  { "<leader>eO", "<Cmd>Other<Cr>",       desc = "[Other] Goto"   },
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
