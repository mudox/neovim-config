install = [[
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
]]

function setup()
  ncmd(',nt', 'NvimTreeToggle')
end
