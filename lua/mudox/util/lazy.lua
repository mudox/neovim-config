local M = {}

function M.has(name)
  return require("lazy.core.config").plugins[name] ~= nil
end

function M.loaded(name)
  return require("lazy.core.config").plugins[name]._.loaded
end

function M.get_opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  return require("lazy.core.plugin").values(plugin, "opts", false)
end

return M
