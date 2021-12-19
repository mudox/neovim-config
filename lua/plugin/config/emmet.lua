vim.g.user_emmet_leader_key = '<C-g>'

-- enable mapping only in insert mode
vim.g.user_emmet_mode = 'a'

-- enable only for html, css files
vim.g.user_emmet_install_global = false
vim.cmd [[ autocmd FileType html,css EmmetInstall ]]
