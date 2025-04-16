local tabman_id = "Kulala"
local function tab_scratchpad()
  vim.cmd.tabnew()
  require("kulala").scratchpad()
end

-- stylua: ignore
local keys = {
  { "<Tab>k", function() X.tabman.open(tabman_id, tab_scratchpad) end,     desc = "[Kulala] Open",     },
  { "<Tab>K", function() X.tabman.recreate(tabman_id, tab_scratchpad) end, desc = "[Kulala] Recreate", },
}

-- stylua: ignore
local opts = {
  icons = {
    inlay = {
      loading = "⧗",
      done    = "✓",
      error   = "✗",
    },
    lualine   = "󰖟 ",
  },
  winbar = true,
}

return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  keys = keys,
  opts = opts,
}
