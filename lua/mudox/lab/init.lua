local M = setmetatable({}, {
  __index = function(u, key)
    u[key] = require("mudox.lab." .. key)
    return u[key]
  end,
})

return M
