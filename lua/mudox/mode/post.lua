-- vim:fdm=marker

-- Color scheme
-- Avoid `:colorsheme` can save ±7ms startuptime
local base16 = require("base16")
base16(base16.themes["gruvbox-dark-hard"], true)
vim.api.nvim_create_autocmd("UIEnter", {
  command = "doautocmd ColorScheme",
})

-- Disable builtin VimScript plugins
local builtins = {
  "2html_plugin",

  "getscript",
  "getscriptPlugin",

  "gzip",

  "logiPat",

  "matchit",

  "matchparen",

  "netrw",
  "netrwFileHandlers",
  "netrwPlugin",
  "netrwSettings",

  "rrhelper",

  "tar",
  "tarPlugin",

  "vimball",
  "vimballPlugin",

  "zip",
  "zipPlugin",
}

for _, plugin in ipairs(builtins) do
  vim.g["loaded_" .. plugin] = 1
end
