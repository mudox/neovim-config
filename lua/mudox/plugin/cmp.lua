url = "hrsh7th/nvim-cmp"

requires = {
  -- Basic sources
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-path" },

  -- Snippets
  { "saadparwaiz1/cmp_luasnip" },

  -- Generic completion sources
  { "hrsh7th/cmp-nvim-lsp" },
  { "ray-x/cmp-treesitter" },
  { "tzachar/cmp-tabnine", run = "./install.sh" },

  -- `rg`
  { "lukas-reineke/cmp-rg" },

  -- Npm
  { "David-Kunz/cmp-npm" },

  -- Lua
  { "hrsh7th/cmp-nvim-lua" },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },
}

for i = 1, #requires do
  local spec = requires[i]
  spec.event = "BufRead"
  spec.after = "nvim-cmp"
end

event = "BufRead"

-- after = { "L3MON4D3/LuaSnip" }
