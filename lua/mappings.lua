-- vim: fdm=marker
vim.g.mapleader = ','

local k = require('keymap')
local nmap = k.nmap
local ncmd = k.ncmd
local imap = k.imap
local icmd = k.icmd
local vmap = k.vmap

nmap('<C-7>', '<C-O>', {noremap = false})
nmap('<C-9>', '<C-I>', {noremap = false})

-- sensible `n, N`
nmap('n', '"Nn"[v:searchforward]', {expr = true})
nmap('N', '"Nn"[v:searchforward]', {expr = true})

-- sensible `Y`
nmap('Y', 'y$')

-- `gs` to replace current word
nmap('gs', 'ciw')

-- `coX` to toggle syntax highlighting
nmap('coX',
     [[:execute 'setlocal syntax=' . ((&syntax == 'OFF') ? 'ON' : 'OFF')<Cr>]])

-- quick save file
ncmd('<C-s>', 'write')
icmd('<C-s>', 'write')

-- sensible `j, k`
nmap('j', 'gj')
nmap('k', 'gk')
nmap('gj', '')
nmap('gk', '')

-- `clrl-J,K,H,L` to jump among windows
nmap('<C-H>', '<C-W>h')
nmap('<C-L>', '<C-W>l')
nmap('<C-K>', '<C-W>k')
nmap('<C-J>', '<C-W>j')

-- `option-J,K,H,L` to jump among tabs
nmap('<M-l>', 'gt')
nmap('<M-h>', 'gT')
nmap('<M-L>', 'gt')
nmap('<M-H>', 'gT')

-- `K, J, H, L` to move cursor up and down in big steps
nmap('K', [[@="8gk"<Cr>]], {silent = true})
nmap('J', [[@="8gj"<Cr>]], {silent = true})
vmap('K', [[@="8gk"<Cr>]], {silent = true})
vmap('J', [[@="8gj"<Cr>]], {silent = true})
nmap('H', '')
nmap('L', '')

-- `q` triggers macro recording easily
-- use `_q` instead
nmap('q', '')
nmap('_q', 'q')
-- nmap('q:', 'q:')
-- nmap('q/', 'q/')

-- `Q` triggers Ex mode easily
-- use gQ instead
nmap('Q', '')

-- sensible `zi`
nmap('zi', 'zizz')

-- command history
-- `nvim_set_keymap` fails to handle `noremap` option
vim.cmd [[cmap <C-P> <Up>]]

-- respawn 2nd pane
-- e.g. re-check, re-run or re-test ...
ncmd('<BS>t', 'silent! !tmux respawn-pane -k -t "{top-right}"')

-- append ';' to the end of line then exit insert mode
-- for languages like C/C++, Rust ...
imap('<C-]>', [[<Cmd>call setline('.', getline('.') .. ';')<Cr><Esc>]])
imap('<C-,>', [[<Cmd>call setline('.', getline('.') .. ';')<Cr><Esc>]])

-- search
nmap('n', 'nzz', {remap = true})
nmap('N', 'Nzz', {remap = true})

-- fold
nmap('zj', 'zjzx', {remap = true})
nmap('zk', 'zkzx', {remap = true})
