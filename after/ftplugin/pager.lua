vim.wo.winhl = "Normal:NormalFloat"
vim.api.nvim_win_set_config(0, {
  title = " 󰆈  messages  ",
  title_pos = "left",
})
K.nmap("<Bs>", K.c("close"), { buffer = true, nowait = true })
