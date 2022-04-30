-- vim:fdm=marker

-- Color scheme
-- Avoid `:colorsheme` can save ±7ms startuptime
local base16 = require("base16")
base16(base16.themes["gruvbox-dark-hard"], true)

-- Adjust some colors
vim.cmd([[
" transparent background
hi Normal guibg=NONE

" transparent column
hi DiffAdd guibg=None
hi DiffDelete guibg=None
hi DiffChange guibg=None

" brighter text
hi Folded guifg=yellow

" brighter border and border title
hi link FloatBorder TelescopeBorder

" lsp highlight cursor
hi default link LspReferenceText CursorColumn
hi default link LspReferenceRead LspReferenceText
hi default link LspReferenceWrite LspReferenceText

" Copilot
hi CopilotSuggestion guifg=#237cff
]])

-- HACK: temporarily fix neovim window resizing issue
-- track: https://github.com/neovim/neovim/issues/11330#issuecomment-900204299
vim.cmd([[ 
autocmd VimEnter * :sleep 1m
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID" 
]])

-- HACK: disable `filetype.vim` loading
-- track: https://github.com/nathom/filetype.nvim#usage
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 1

-- Disable builtin plugins
local builtins = {
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "matchit",
  "matchparen",
  "logiPat",
  "rrhelper",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
}

for _, plugin in ipairs(builtins) do
  vim.g["loaded_" .. plugin] = 1
end
