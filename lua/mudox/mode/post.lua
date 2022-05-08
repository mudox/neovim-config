-- vim:fdm=marker

-- Color scheme
-- Avoid `:colorsheme` can save ±7ms startuptime
local base16 = require("base16")
base16(base16.themes["gruvbox-dark-hard"], true)
vim.api.nvim_create_autocmd("UIEnter", {
  command = "doautocmd ColorScheme",
})

-- HACK: fix neovim window resizing issue when used as terminal initial command
-- track: https://github.com/neovim/neovim/issues/11330#issuecomment-900204299
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      vim.loop.kill(vim.fn.getpid(), vim.loop.constants.SIGWINCH)
    end, 1)
  end,
})

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
