local rocks_dir = vim.fn.stdpath("config") .. "/lua/rocks"

local path_dir = rocks_dir .. "/share/lua/5.1"
package.path = table.concat({
  ([[%s/?.lua]]):format(path_dir),
  ([[%s/?/init.lua]]):format(path_dir),
  package.path,
}, ";")

local cpath_dir = rocks_dir .. "/lib/lua/5.1"
package.cpath = table.concat({ ([[%s/?.so]]):format(cpath_dir), package.cpath }, ";")

-- penlight
return require("pl.import_into")()
