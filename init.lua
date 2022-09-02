-- vim: fdm=marker fmr=〈,〉

-- Luarocks
pl = require("mudox.luarocks")

-- Mode
require("mudox.resolve_mode")

-- Common paths
stdpath = require("mudox.path")

-- Config
require(stdpath("settings"))
require(stdpath("auto_commands"))
require("mudox.plugin_manager")
require(stdpath("post"))

-- Mappings
local gid = vim.api.nvim_create_augroup("MudoxKeymap", { clear = true })
vim.api.nvim_create_autocmd("UIEnter", {
  group = gid,
  callback = function()
    require(stdpath("mappings"))
  end,
})

-- Packer
local path = stdpath.packer_compiled
if vim.fn.filereadable(path) == 1 then
  dofile(path)
else
  require("mudox.plugin.config.notify")
  local text = "Compiled file does not exists in"
    .. ("\n%s\n"):format(path)
    .. "\n1. Try to compile it"
    .. "\n2. Now restart Neovim manually"
  require("notify")(text, "warn", { title = "Packer", timeout = 100000 })

  vim.cmd("PackerCompile")
end
