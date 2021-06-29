" vim: fdm=marker

if exists('s:loaded')
  finish
end
let s:loaded = v:true

" performance
let g:airline_highlighting_cache = 1

let g:airline_exclude_preview = 1

let g:airline_skip_empty_sections = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

let g:airline_stl_path_style = 'short'
let g:airline_section_c_only_filename = 1

let g:airline_extensions = ['tabline', 'coc', 'tmuxline']

" tabline {{{1
let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_count = 0
let airline#extensions#tabline#disable_refresh = 0

let g:airline#extensions#tabline#excludes = ['^$']
let airline#extensions#tabline#ignore_bufadd_pat =
      \ '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree'

let g:airline#extensions#tabline#close_symbol = ''

" " tab & buffer index
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#show_tab_nr = 0

" shorten texts
let g:airline#extensions#tabline#show_tab_type = 0
" let g:airline#extensions#tabline#buffers_label = 'b'
" let g:airline#extensions#tabline#tabs_label = 't'
let g:airline#extensions#tabline#fnamemod = ':t:r'

" }}}1

" tmuxline
let g:airline#extensions#tmuxline#enabled = 1
let g:tmuxline_preset = 'crosshair'

" coc
let airline#extensions#coc#error_symbol = ''
let airline#extensions#coc#warning_symbol = ''

nnoremap yoa <Cmd>AirlineToggle<Cr>

let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ ''     : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ }

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

"
" symbol
"

let g:airline_powerline_fonts = 1
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.linenr = '☰'
