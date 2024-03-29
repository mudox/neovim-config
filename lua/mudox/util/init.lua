local M = setmetatable({}, {
  __index = function(u, key)
    u[key] = require("mudox.util." .. key)
    return u[key]
  end,
})

-- HACK: status column redrawing currently not triggers enough
function M.redraw_status_column()
  vim.opt_local.statuscolumn = vim.opt_local.statuscolumn
end

return M
