vim.wo.winhl = "Normal:mdx_b"
vim.api.nvim_win_set_config(0, {
  title = "    messages  ",
  title_pos = "left",
})
K.nmap("<Bs>", K.c("close"), { buffer = true, nowait = true })
K.nmap("q", K.c("close"), { buffer = true, nowait = true, remap = false }) -- overriden by _extui/shared.lua
