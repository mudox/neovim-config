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

local function config(_, o)
  require("other-nvim").setup(o)
end

local keys = {
  { "<leader>wo", "<Cmd>Other<Cr>", desc = "[Other] Open alternative file" },
  { "<leader>wv", "<Cmd>Other<Cr>", desc = "[Other] Open alternative file in vsplit" },
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
  config = config,
}
