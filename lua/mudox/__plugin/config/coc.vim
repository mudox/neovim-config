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
imap <silent><expr> <TAB>
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>emmet_expandable() ? "\<plug>(emmet-expand-abbr)" :
      \ pumvisible() ? coc#_select_confirm() :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" check if prefix can be expanded by emmet (only in given file types)
function! s:emmet_expandable() abort
  let fts = ['html', 'css']
  return index(fts, &ft) >= 0 && emmet#isExpandable()
endfunction

" return true if is in the 1st column or before a white space
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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
  inoremap <expr> <Cr> complete_info()["selected"] != "-1" ?  coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
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
xmap gX  <Plug>(coc-codeaction-line)
" for entire file
nmap gx  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap \qf  <Plug>(coc-fix-current)
" 〉

" Textobject & range 〈
" Map function and class text objects
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

" CoCList 〈

" All lsits
nnoremap <silent> <C-C><Space>  <Cmd>CocList lists<Cr>
" Resume previous list
nnoremap <silent> <C-C><C-C>  <Cmd>CocListResume<Cr>
" Commands
nnoremap <silent> <C-C>c  <Cmd>CocList commands<Cr>
" Actions
nnoremap <silent> <C-C>x  <Cmd>CocAction<Cr>
" Diagnostics
nnoremap <silent> <C-C>?  <Cmd>CocList diagnostics<Cr>
" Extensions.
nnoremap <silent> <C-C>e  <Cmd>CocList extensions<Cr>
" Outline
nnoremap <silent> <C-C>@  <Cmd>CocList outline<Cr>
" Workspace symbols
nnoremap <silent> <C-C>#  <Cmd>CocList -I symbols<Cr>

" Do default action for next item.
nnoremap <silent> <C-C>.  <Cmd>CocNext<Cr>
" Do default action for previous item.
nnoremap <silent> <C-C>,  <Cmd>CocPrev<Cr>

" 〉

" Extension Configurations 〈

" coc-git
nnoremap yog <Cmd>CocCommand git.toggleGutters<Cr>

" coc-yank
nnoremap <silent> <C-C>y  <Cmd>CocList -A yank<Cr>

" coc-css
autocmd FileType scss setl iskeyword+=@-@

" coc-highlight
nnoremap <M-,>c <Cmd>call CocAction('pickColor')<Cr>
nnoremap <M-,>C <Cmd>call CocAction('colorPresentation')<Cr>

" coc-marketplace
nnoremap <silent> <C-C>m  <Cmd>CocList marketplace<Cr>

" coc-file-browser
nnoremap <silent> <M-/>e <Cmd>CocCommand explorer<Cr>

" 〉

" Mappings  〈
nnoremap <silent> <M-/>o <Cmd>CocOutline<Cr>
"  〉
