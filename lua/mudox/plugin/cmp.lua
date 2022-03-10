url = "hrsh7th/nvim-cmp"

requires = {
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-path" },

  -- snippets
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lua" },

  -- omni completion sources
  { "hrsh7th/cmp-nvim-lsp" },
  { "tzachar/cmp-tabnine", run = "./install.sh" },
}

for i = 1, #requires do
  local spec = requires[i]
  spec.event = "BufRead"
  spec.after = "nvim-cmp"
end

event = "BufRead"

-- after = { "L3MON4D3/LuaSnip" }
