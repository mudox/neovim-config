-- vim: fml& fdn& fdm=marker fmr=〈,〉

local o = vim.o
local opt = vim.opt

-- UI 〈

o.winblend = 0 -- pseudo-transparent makes kitty renders icon in half width

o.mouse = "a"

-- stylua: ignore
opt.fillchars = {
  eob       = " ",

  -- Pane separators
  -- horiz     = "─",
  -- horizup   = "┴",
  -- horizdown = "┬",
  -- vert      = "│",
  -- vertleft  = "┤",
  -- vertright = "├",
  -- verthoriz = "┼",

  -- Pane separators
  -- horiz     = "━",
  -- horizup   = "┻",
  -- horizdown = "┳",
  --
  -- vert      = "┃",
  -- vertleft  = "┫",
  -- vertright = "┣",
  --
  -- verthoriz = "╋",

  diff      = '╱',

  fold      = ' ',
  foldopen  = require("mudox.ui.icon").chevron.down,
  foldclose = require("mudox.ui.icon").chevron.right,
  foldsep   = ' ',
}

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
-- stylua: ignore
opt.shortmess:append {
  I  = true, -- `:into` at startup
  A  = true, -- swap file messages
  cC = true, -- completion menu messages
  s  = true, -- search messages
  W  = true, -- bytes written messages
}

-- cursor
opt.guicursor = {
  "n-v-c-sm:block-blinkwait1300-blinkon200",
  "i-ci-ve:ver25-Cursor-blinkon200-blinkoff150",
  "r-cr-o:hor20-blinkwait300-blinkon200",
}

o.foldcolumn = "auto:1"

-- 〉

-- Tab & indent 〈

o.tabstop = 2
o.softtabstop = 2
o.smarttab = true
o.expandtab = true

o.shiftwidth = 2
o.shiftround = true

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

-- Editing 〈

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

o.pumblend = 0 -- pseudo-transparent makes kitty renders icon in half width
o.pumheight = 10

o.completeopt = "menu,menuone,noselect"
o.wildignorecase = true

o.dictionary = [[/usr/share/dict/words]]

-- 〉

-- Font 〈

-- o.linespace = 0

-- 〉

-- Tmp file 〈

o.hidden = true -- Many plugins need this feature
o.backup = false
o.writebackup = false
o.swapfile = false

-- 〉

-- Languages 〈
-- disable providers to reduce startup time unless is needed

-- JavaScript
vim.g.loaded_node_provider = 0
-- vim.g.node_host_prog = "/Users/mudox/Library/pnpm/neovim-node-host"

-- Python
vim.g.loaded_python3_provider = 0
-- vim.g.python3_host_prog = "/Users/mudox/.pyenv/shims/python"

-- Ruby
vim.g.loaded_ruby_provider = 0

-- Perl
vim.g.loaded_perl_provider = 0

-- 〉

-- Misc 〈

-- opt.diffopt:append("linematch:60")

-- grep
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep"

o.formatoptions = "jcroqlnt"

o.timeoutlen = 300
o.updatetime = 200

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- diff
opt.diffopt:append {
  "vertical",
  "algorithm:histogram",
  "linematch:60",
}

-- Misc 〉

require("tokyonight").load()
