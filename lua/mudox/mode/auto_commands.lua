-- Equal panes when window resized
local gid = vim.api.nvim_create_augroup("MudoxEqualPanes", { clear = true })
vim.api.nvim_create_autocmd("VimResized", {
  group = gid,
  command = "tabdo wincmd =",
})

-- Press `q` to close buffer
gid = vim.api.nvim_create_augroup("MudoxMisc", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = gid,
  pattern = { "qf", "help", "man", "lspinfo", "null-ls-info" },
  command = "nnoremap <silent> <buffer> q <Cmd>close<Cr>",
})
vim.api.nvim_create_autocmd("FileType", {
  group = gid,
  pattern = { "qf" },
  command = "setlocal nobuflisted",
})
