-- auto equal panes
vim.cmd([[
augroup mdx_equal_panes
  autocmd!
  autocmd VimResized * tabdo wincmd = 
augroup end
]])

-- mappings & settings for special buffers
vim.cmd([[
augroup mdx_general_auto_commands
  autocmd!
  autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q <Cmd>close<Cr> 
  autocmd FileType qf set nobuflisted
augroup end
]])
