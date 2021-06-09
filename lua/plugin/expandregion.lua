install = [[
Plug 'https://github.com/terryma/vim-expand-region.git'
]]

function setup()
  nplug('v', 'expand_region_expand')
  nplug('V', 'expand_region_shrink')
end

