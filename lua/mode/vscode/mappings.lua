-- vim: fdm=marker
local k = require('keymap')

vim.g.mapleader = ','

k.nmap('<C-7>', '<C-O>', {noremap = false})
k.nmap('<C-9>', '<C-I>', {noremap = false})

-- sensible `n, N`
k.nmap('n', '"Nn"[v:searchforward]', {expr = true})
k.nmap('N', '"Nn"[v:searchforward]', {expr = true})

-- sensible `Y`
k.nmap('Y', 'y$')

-- `gs` to replace current word
k.nmap('gs', 'ciw')

-- `coX` to toggle syntax highlighting
k.nmap('coX',
       [[:execute 'setlocal syntax=' . ((&syntax == 'OFF') ? 'ON' : 'OFF')<Cr>]])

-- `F4` to quick save file
k.nmap('<F4>', [[:<C-U><C-U>w<Cr>]])

-- sensible `j, k`
k.nmap('j', 'gj')
k.nmap('k', 'gk')
k.nmap('gj', '')
k.nmap('gk', '')

-- `clrl-J,K,H,L` to jump among windows
k.nmap('<C-H>', '<C-W>h')
k.nmap('<C-L>', '<C-W>l')
k.nmap('<C-K>', '<C-W>k')
k.nmap('<C-J>', '<C-W>j')

-- `option-J,K,H,L` to jump among tabs
k.nmap('<M-l>', 'gt')
k.nmap('<M-h>', 'gT')
k.nmap('<M-L>', 'gt')
k.nmap('<M-H>', 'gT')

-- `K, J, H, L` to move cursor up and down in big steps
k.nmap('K', [[@="8gk"<Cr>]], {silent = true})
k.nmap('J', [[@="8gj"<Cr>]], {silent = true})
k.vmap('K', [[@="8gk"<Cr>]], {silent = true})
k.vmap('J', [[@="8gj"<Cr>]], {silent = true})
k.nmap('H', '')
k.nmap('L', '')

-- `q` triggers macro recording easily
-- use `_q` instead
k.nmap('q', '')
k.nmap('_q', 'q')
-- nmap('q:', 'q:')
-- nmap('q/', 'q/')

-- `Q` triggers Ex mode easily
-- use gQ instead
k.nmap('Q', '')

-- sensible `zi`
k.nmap('zi', 'zizz')

-- problem navigation
k.ncmd('[g', 'call VSCodeNotify("editor.action.marker.prev")')
k.ncmd(']g', 'call VSCodeNotify("editor.action.marker.next")')
