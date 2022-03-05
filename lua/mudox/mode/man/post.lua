-- prevent plugin loading
vim.g.loaded_netrwPlugin = true

-- color scheme
-- avoid `:colorsheme` can save ±7ms startuptime
local base16 = require("base16")
base16(base16.themes["gruvbox-dark-hard"], true)
