-- vim: fdm=marker fmr=\ 〈,\ 〉
---@diagnostic disable: unused-local

-- Language client 〈

-- JavaScript
vim.g.node_host_prog = "/opt/homebrew/bin/neovim-node-host"

-- Python
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = "/Users/mudox/.pyenv/shims/python"

-- 〉

-- Helpers 〈
local home = os.getenv("HOME")

-- Access vim remote plugin api
local a = vim.api

-- Access vim global variables
local g = vim.g

-- Access vim global options
local o = vim.o
local opt = vim.opt

-- Execute vim commands
local cmd = vim.cmd

-- Call vim functions
local fn = vim.fn
-- 〉

-- Indent 〈
o.autoindent = true
o.smartindent = true
-- 〉

-- UI 〈
o.termguicolors = true

o.mouse = "a"

-- stylua: ignore start
opt.fillchars = {
  eob = " ",

  -- Pane separators
  horiz     = "━",
  horizup   = "┻",
  horizdown = "┳",

  vert      = "┃",
  vertleft  = "┫",
  vertright = "┣",

  verthoriz = "╋",

  diff      = '╱'
}
-- stylua: ignore end

o.signcolumn = "auto:1-2"

o.cursorline = false
o.number = false

o.splitright = true
o.splitbelow = true

-- Overriden by `lualine`
o.showtabline = 0

-- Overriden by `lualine`
o.laststatus = 3 -- Global statusline

o.showcmd = false
o.ruler = false

o.cmdheight = 2

opt.shortmess:append("I") -- Not show `:intro` on startup
opt.shortmess:append("c") -- Not show insert completion menu message

o.scrolloff = 8
o.sidescrolloff = 8

-- 〉

-- Tabs 〈
o.tabstop = 8
o.softtabstop = 4
o.shiftwidth = 4
o.smarttab = true
o.expandtab = true
o.listchars = [[tab:▸-,eol:¶]]
-- 〉

-- Pattern search 〈
o.hlsearch = false
o.wrapscan = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.inccommand = "nosplit"
-- 〉

-- Editing behavior 〈
o.whichwrap = [[b,s,<,>,[,],h,l]]
o.autochdir = false
o.autowriteall = true -- Auto-save aggressively
-- 〉

-- Completion 〈
o.completeopt = "menuone,noselect"
o.dictionary = [[/usr/share/dict/words]]
o.wildignorecase = true
-- 〉

-- Font 〈
o.guifont = "Monaco for Powerline:h11"
o.linespace = 0
-- 〉

-- Tmp file 〈
o.hidden = true -- Many plugins need this feature
o.backup = false
o.writebackup = false
o.swapfile = false
-- 〉
