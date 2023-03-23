-- vim: fdm=marker fmr=\ 〈,\ 〉

local o = vim.o
local opt = vim.opt

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

o.listchars = [[tab:▸-,eol:¶]]

o.cursorline = false
o.number = false

-- tab line
o.showtabline = 0

-- status line
o.laststatus = 3 -- Global statusline
o.showmode = false
o.showcmd = false
o.ruler = false

-- command line
o.cmdheight = 2
opt.wildmode = "longest:full,full"

-- message
opt.shortmess:append("I") -- Not show `:intro` on startup
opt.shortmess:append("c") -- Not show insert completion menu message
if vim.fn.has("nvim-0.9.0") == 1 then
  opt.shortmess:append("C")
end

-- 〉

-- Tab & indent 〈

o.tabstop = 8
o.softtabstop = 4
o.shiftwidth = 4
o.smarttab = true
o.expandtab = true

o.autoindent = true
o.smartindent = true

-- 〉

-- Search 〈

o.hlsearch = false
o.wrapscan = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.inccommand = "nosplit"

-- 〉

-- Editor 〈

o.whichwrap = [[b,s,<,>,[,],h,l]]
o.autochdir = false

o.autowriteall = true

o.scrolloff = 8
o.sidescrolloff = 8

o.splitright = true
o.splitbelow = true
if vim.fn.has("nvim-0.9.0") == 1 then
  o.splitkeep = "screen"
end

-- 〉

-- Completion 〈

o.pumblend = 10
o.pumheight = 10
o.completeopt = "menu,menuone,noselect"
o.dictionary = [[/usr/share/dict/words]]
o.wildignorecase = true

-- 〉

-- Font 〈

o.linespace = 0

-- 〉

-- Tmp file 〈

o.hidden = true -- Many plugins need this feature
o.backup = false
o.writebackup = false
o.swapfile = false

-- 〉

-- Grep
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep"

o.formatoptions = "jcroqlnt"

o.timeoutlen = 300
o.updatetime = 200

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Language clients 〈

-- JavaScript
vim.g.node_host_prog = "/opt/homebrew/bin/neovim-node-host"

-- Python
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = "/Users/mudox/.pyenv/shims/python"

-- 〉

-- Colorscheme
require("tokyonight").load()
-- require("catppuccin").load()
