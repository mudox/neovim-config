---@param plugin string
local function has(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

---@param name string
local function get_opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  require("lazy.core.plugin").values(plugin, "opts", false)
end

return {
  has = has,
  get_opts = get_opts,
}
