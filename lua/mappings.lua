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
k.nmap('<C-s>', [[:<C-U><C-U>w<Cr>]])
k.imap('<F4>', [[<Esc>:w<Cr>]])
k.imap('<C-s>', [[<Esc>:w<Cr>]])

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

-- command history
-- `nvim_set_keymap` fails to handle `noremap` option
vim.cmd [[cmap <C-P> <Up>]]

-- respawn 2nd pane
-- e.g. re-check, re-run or re-test ...
k.ncmd('<BS>t', 'silent! !tmux respawn-pane -k -t .2')

-- append ';' to the end of line then exit insert mode
-- for languages like C/C++, Rust ...
k.imap('<C-]>', [[<Cmd>call setline('.', getline('.') .. ';')<Cr><Esc>]])
k.imap('<C-,>', [[<Cmd>call setline('.', getline('.') .. ';')<Cr><Esc>]])

-- search
k.nmap('n', 'nzz', {remap = true})
k.nmap('N', 'Nzz', {remap = true})
