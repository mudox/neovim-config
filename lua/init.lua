-- vim: fdm=marker

-- common paths
local p = {}
p.root = vim.fn.stdpath("config")
p.plugin = p.root .. "/plugin"
p.ftplugin = p.root .. "/ftplugin"
p.autoload = p.root .. "/autoload"
p.lua = p.root .. "/lua"
p.rocks = p.lua .. "/.rocks"
p.luaplugin = p.lua .. "/plugin"

stdpath = {}
setmetatable(
  stdpath,
  {
    __index = function(_, id)
      local r = p[id]
      assert(r, ("acessing invalid path id `%s`"):format(id))
      return r
    end,
    __newindex = function()
      error("`stdpath` is a constant variable")
    end
  }
)

-- package path
local path_dir = stdpath.rocks .. "/share/lua/5.1"
package.path =
  table.concat(
  {
    ([[%s/?.lua]]):format(path_dir),
    ([[%s/?/init.lua]]):format(path_dir),
    package.path
  },
  ";"
)

local cpath_dir = stdpath.rocks .. "/lib/lua/5.1"
package.cpath =
  table.concat(
  {
    ([[%s/?.so]]):format(cpath_dir),
    package.cpath
  },
  ";"
)

-- node.js
vim.g.node_host_prog = "/usr/local/bin/neovim-node-host"

-- python
vim.g.loaded_python_provider = 0
-- vim.g.python3_host_prog = "/Users/mudox/.pyenv/versions/3.7.9/bin/python"
vim.g.python3_host_prog = "/opt/homebrew/bin/python3"

-- local plugin
local function append_rtp(path)
  local join = require("pl.path").join
  local item = join(stdpath.root, path)
  vim.o.runtimepath = vim.o.runtimepath .. "," .. item
end

if vim.fn.has("vim_starting") then
  append_rtp "bundle/align"
end

-- convenient `dump` function
function dump(obj)
  print(require("inspect")(obj))
end

-- config
if vim.fn.exists("g:vscode") == 1 then
  require "vscode.main"
else
  require "main"
end
