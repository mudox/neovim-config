set hlsearch

" fix
" track: https://github.com/neovim/neovim/issues/12409
if g:mdx_nvim_mode == 'man'
  nnoremap <silent> <buffer> <nowait> q <Cmd>quitall<Cr>
endif
