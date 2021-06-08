install = [[
Plug 'https://github.com/tpope/vim-unimpaired.git'
]]

function setup()
  nmap("coh", ":<C-U><C-U>set hlsearch!<Cr>")
end
