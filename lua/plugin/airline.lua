install = [[
  Plug 'vim-airline/vim-airline'
]]

function setup()
  vim.g.airline_powerline_fonts = 1
  vim.g.airline_extensions = {}

  -- experiment: boost highlighting speed
  vim.g.airline_highlighting_cache = 1
end
