vim.loader.enable(true)

-- Convenient globals
require("mudox.globals")

-- Load plugins
require("mudox.lazy")

-- Colorscheme
require("tokyonight").load()

-- Settings & Autocmds
-- require("../../lua/mudox/settings.lua")
-- require("../../mudox/autocmds")
-- require("../../mudox.keymaps")
X.dirop.setup()
