-- vim: fdm=marker fmr=\ 〈,\ 〉

local o = vim.o
local opt = vim.opt

-- UI 〈

o.termguicolors = true

o.mouse = "a"

-- stylua: ignore start
opt.fillchars = {
  eob       = " ",

  -- Pane separators
  horiz     = "━",
  horizup   = "┻",
  horizdown = "┳",

  vert      = "┃",
  vertleft  = "┫",
  vertright = "┣",

  verthoriz = "╋",

  diff      = '╱',

  foldopen  = '',
  foldsep   = ' ',
  foldclose = ''
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
opt.shortmess:append("c") -- Not show insert completion menu messages
opt.shortmess:append("s") -- Not show `Hit Bottom / Top ...` messages
opt.shortmess:append("C") -- Not show `scanning tags` messages

opt.guicursor = "n-v-c-sm:block-blinkwait1300-blinkon200"
opt.guicursor:append("i-ci-ve:ver25-Cursor-blinkon200-blinkoff150")
opt.guicursor:append("r-cr-o:hor20-blinkwait300-blinkon200")

-- 〉

-- Tab & indent 〈

o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.smarttab = true
o.expandtab = true

o.autoindent = true
o.smartindent = true

o.breakindent = true
o.copyindent = true

-- 〉

-- Search 〈

o.hlsearch = true
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
o.smoothscroll = true

o.splitright = true
o.splitbelow = true
o.splitkeep = "screen"

o.virtualedit = "block"

o.selection = "old"

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

opt.diffopt:append("linematch:60")

-- Grep
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep"

o.formatoptions = "jcroqlnt"

o.timeoutlen = 300
o.updatetime = 200

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Disable language providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Language clients 〈

-- JavaScript
vim.g.node_host_prog = "/opt/homebrew/bin/neovim-node-host"

-- Python
vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = "/Users/mudox/.pyenv/shims/python"

-- 〉

-- Colorscheme
require("tokyonight").load()
-- require("kanagawa").load()
-- require("catppuccin").load()
