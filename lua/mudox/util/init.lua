local M = setmetatable({}, {
  __index = function(u, key)
    u[key] = require("mudox.util." .. key)
    return u[key]
  end,
})

return M
