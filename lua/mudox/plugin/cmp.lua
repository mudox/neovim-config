url = "hrsh7th/nvim-cmp"

requires = {
  -- Basic sources
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-cmdline" },
  { "dmitmel/cmp-cmdline-history" },
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

  -- Dict
  { "octaltree/cmp-look" },
}

event = "BufRead"

for i = 1, #requires do
  local spec = requires[i]
  spec.event = event
  spec.after = "nvim-cmp"
end

if mode == "lsp" then
  -- NOTE: critical
  after = { "LuaSnip" }
end
