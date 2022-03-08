-- vim: fdm=marker fmr=\ 〈,\ 〉
---@diagnostic disable: unused-local

-- language client 〈

-- JavaScript
vim.g.node_host_prog = "/opt/homebrew/bin/neovim-node-host"

-- Python
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = "/Users/mudox/.pyenv/shims/python"

-- 〉

-- helpers 〈
local home = os.getenv("HOME")

-- access vim remote plugin api
local a = vim.api

-- access vim global variables
local g = vim.g

-- access vim global options
local o = vim.o
local opt = vim.opt

-- execute vim commands
local cmd = vim.cmd

-- call vim functions
local fn = vim.fn
-- 〉

-- indent 〈
o.autoindent = true
o.smartindent = true
-- 〉

-- UI 〈
o.termguicolors = true

o.mouse = "a"

o.fillchars = "eob: "

o.cursorline = false
o.number = false

o.splitright = true
o.splitbelow = true

-- overriden by `lualine`
o.showtabline = 0
o.laststatus = 2
o.showcmd = false
o.ruler = false

o.cmdheight = 2

opt.shortmess:append("I") -- not show `:intro` on startup
opt.shortmess:append("c") -- not show insert completion menu message

o.scrolloff = 8
o.sidescrolloff = 8

o.signcolumn = "auto:2"

-- transparent background for float windows
-- document highlighting style
vim.cmd([[
  hi default link NormalFloat Normal

  hi default link LspReferenceText CursorColumn
  hi default link LspReferenceRead LspReferenceText
  hi default link LspReferenceWrite LspReferenceText
]])

-- unify all window with borders use "rounded" border style
local orig_nvim_open_win = vim.api.nvim_open_win
function vim.api.nvim_open_win(buffer, enter, opts)
  opts = opts or {}
  if opts.border then
    opts.border = "rounded"
  end
  return orig_nvim_open_win(buffer, enter, opts)
end

-- 〉

-- tabs 〈
o.tabstop = 8
o.softtabstop = 4
o.shiftwidth = 4
o.smarttab = true
o.expandtab = true
o.listchars = [[tab:▸-,eol:¶]]
-- 〉

-- pattern search 〈
o.hlsearch = false
o.wrapscan = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.inccommand = "nosplit"
-- 〉

-- editing behavior 〈
o.whichwrap = [[b,s,<,>,[,],h,l]]
o.autochdir = false
o.autowriteall = true -- auto-save aggressively
-- 〉

-- completion 〈
o.completeopt = "menuone,noselect"
o.dictionary = [[/usr/share/dict/words]]
o.wildignorecase = true
-- 〉

-- font 〈
o.guifont = "Monaco for Powerline:h11"
o.linespace = 0
-- 〉

-- tmp file 〈
o.hidden = true -- many plugins need this feature
o.backup = false
o.writebackup = false
o.swapfile = false
-- 〉
