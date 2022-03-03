-- vim: fdm=marker fmr=\ 〈,\ 〉
---@diagnostic disable: unused-local

-- helpers 〈
local home = os.getenv "HOME"

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
o.cursorline = false
o.fillchars = "eob: "
o.mouse = "a"

o.number = false

o.ruler = false

o.showtabline = 1

o.splitright = true
o.splitbelow = true

o.laststatus = 0
o.cmdheight = 2
o.showcmd = false

opt.shortmess:append("I") -- not show `:intro` on startup
opt.shortmess:append("c") -- not show insert completion menu message

o.scrolloff = 8
o.sidescrolloff = 8

o.signcolumn = "auto:3"
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
o.hidden = false
o.backup = false
o.writebackup = false
o.swapfile = false
-- 〉
