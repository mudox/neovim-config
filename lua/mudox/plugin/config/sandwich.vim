let g:sandwich_no_default_key_mappings = 1

let prefix = "<M-'>"

" add
execute 'silent! map <unique> ' . prefix . 'a <Plug>(sandwich-add)'

" delete
execute 'silent! nmap <unique> ' . prefix . 'd <Plug>(sandwich-delete)'
execute 'silent! xmap <unique> ' . prefix . 'd <Plug>(sandwich-delete)'
execute 'silent! nmap <unique> ' . prefix . 'db <Plug>(sandwich-delete-auto)'

" replace
execute 'silent! nmap <unique> ' . prefix . 'r <Plug>(sandwich-replace)'
execute 'silent! xmap <unique> ' . prefix . 'r <Plug>(sandwich-replace)'
execute 'silent! nmap <unique> ' . prefix . 'rb <Plug>(sandwich-replace-auto)'
