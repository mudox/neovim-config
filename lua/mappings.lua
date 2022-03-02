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

-- `option-J,K,H,L` to jump among tabs
ncmd('<M-]>', 'bnext')
ncmd('<M-[>', 'bNext')
nmap('<M-l>', 'gt')
nmap('<M-h>', 'gT')

-- `q` triggers macro recording easily
nmap('<M-k>', 'q')
nnop('q')
-- nmap('q:', 'q:')
-- nmap('q/', 'q/')

-- `Q` triggers Ex mode easily
nnop('Q')

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
nmap('n', 'nzvzz', {remap = true})
nmap('N', 'Nzvzz', {remap = true})

-- fold
nmap('zj', 'zjzx', {remap = true})
nmap('zk', 'zkzx', {remap = true})
