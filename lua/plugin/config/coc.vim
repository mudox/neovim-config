" vim: fdm=marker fmr=\ 〈,\ 〉

" Neovim options 〈
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  " set signcolumn=number
" else
  " set signcolumn=yes
" endif
" 〉

" Completion Trigger 〈
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
if has('nvim')
inoremap <silent><expr> <c-space> coc#refresh()
else
inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <Cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <Cr> could be remapped by other vim plugin, try `:verbose imap <Cr>`.
if exists('*complete_info')
  inoremap <expr> <Cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<Cr>"
else
  inoremap <expr> <Cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<Cr>"
endif
" 〉

" Misc 〈
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use gh to show documentation in preview window.
nnoremap <silent> gh :call <SID>show_documentation()<Cr>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h ' . expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" 〉

" Cod Action 〈
" Example: `<leader>xap` for current paragraph
" for current line
xmap gx  <Plug>(coc-codeaction-line)
" for entire file
nmap gX  <Plug>(coc-codeaction) 

" Apply AutoFix to problem on the current line.
nmap \qf  <Plug>(coc-fix-current)
" 〉

" Textobject & range 〈
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)
" 〉

" Commands 〈
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" 〉

" Statusline 〈
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" 〉

" CoCList 〈

" Note: use `Telescope coc ...` instead

" Show all diagnostics.
nnoremap <silent> <C-C>?  <Cmd>CocList diagnostics<Cr>
" Manage extensions.
nnoremap <silent> <C-C>e  <Cmd>CocList extensions<Cr>
" Show commands
nnoremap <silent> <C-C>c  <Cmd>CocList commands<Cr>
" Find symbol of current document.
nnoremap <silent> <C-C>@  <Cmd>CocList outline<Cr>
" Search workspace symbols.
nnoremap <silent> <C-C>#  <Cmd>CocList -I symbols<Cr>
" Do default action for next item.
nnoremap <silent> <C-C>j  <Cmd>CocNext<Cr>
" Do default action for previous item.
nnoremap <silent> <C-C>k  <Cmd>CocPrev<Cr>
" Resume latest coc list.
nnoremap <silent> <C-C><C-C>  <Cmd>CocListResume<Cr>
" Show action menu
nnoremap <silent> <C-C>x  <Cmd>CocAction<Cr>

" file explorer
nnoremap <C-C>f <Cmd>CocCommand explorer<Cr>
" 〉

" Extension Configurations 〈

" coc-css
autocmd FileType scss setl iskeyword+=@-@

" coc-highlight
nnoremap <C-m>c <Cmd>call CocAction('pickColor')<Cr>
nnoremap <C-m>C <Cmd>call CocAction('colorPresentation')<Cr>

" 〉
