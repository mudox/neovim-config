let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1

let g:airline_exclude_preview = 1

let g:airline_skip_empty_sections = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

let g:airline_stl_path_style = 'short'
let g:airline_section_c_only_filename = 1

let g:airline_extensions = ['tabline', 'coc']

" tabline
let g:airline#extensions#tabline#enabled = 1

" coc
let airline#extensions#coc#error_symbol = 'E:'
let airline#extensions#coc#warning_symbol = 'W:'


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

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.linenr = '☰'

AirlineRefresh!