-- vim: fdm=marker fmr=\ 〈,\ 〉

-- Auto equal panes 〈

local gid = vim.api.nvim_create_augroup("MudoxEqualPanes", { clear = true })
vim.api.nvim_create_autocmd("VimResized", {
  group = gid,
  callback = function()
    local tab = vim.fn.tabpagenr()
    vim.fn.execute("tabdo wincmd =")
    vim.fn.execute("tabnext " .. tab)
  end,
})

-- 〉

-- Close sepcial panes 〈

-- Press `q` to close buffer
gid = vim.api.nvim_create_augroup("MudoxQ", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = gid,
  pattern = { "qf", "help", "lspinfo", "null-ls-info", "notify" },
  command = "nnoremap <silent> <buffer> q <Cmd>close<Cr>",
})

vim.api.nvim_create_autocmd("FileType", {
  group = gid,
  pattern = "man",
  callback = function()
    local ncmd = require("mudox.keymap").ncmd
    if vim.g.mdx_nvim_mode == "man" then
      ncmd("q", "quitall!")
    else
      ncmd("q", "quit")
    end
  end,
})

-- 〉

-- Nobuflisted 〈

vim.api.nvim_create_autocmd("FileType", {
  group = gid,
  pattern = { "qf" },
  command = "setlocal nobuflisted",
})

-- 〉

-- Colorscheme 〈

local c = require("mudox.ui").colors
local d = c.diff
local cmd = table.concat({
  -- transparent background
  "hi Normal guibg=NONE",

  -- transparent sign column
  "hi GitGutterAdd guibg=NONE",
  "hi GitGutterDelete guibg=NONE",
  "hi GitGutterChange guibg=NONE",

  -- diff
  ("hi DiffAdd guibg=%s"):format(d.add.bg),
  ("hi DiffDelete guibg=%s"):format(d.delete.bg),
  ("hi DiffChange guifg=%s guibg=%s"):format(d.change.fg, d.change.bg),
  ("hi DiffText guifg=%s"):format(d.text.fg),

  -- brighter text
  "hi Folded guifg=#999999 guibg=NONE",

  -- brighter border and border title
  "hi link FloatBorder TelescopeBorder",

  -- lsp highlight cursor
  "hi default link LspReferenceText CursorColumn",
  "hi default link LspReferenceRead LspReferenceText",
  "hi default link LspReferenceWrite LspReferenceText",

  -- copilot
  "hi CopilotSuggestion guifg=#237cff",
}, "\n")

gid = vim.api.nvim_create_augroup("MudoxColorScheme", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = gid,
  command = cmd,
})

-- 〉
