-- stylua: ignore
local function r(name) return require("mudox.plugin.mini." .. name) end

local modules = {
  "bufremove",
  "icons",
}

local function setup()
  for _, name in ipairs(modules) do
    r(name).setup()
  end
end

local keys = (function()
  local ret = {}
  for _, name in ipairs(modules) do
    vim.list_extend(ret, r(name).keys or {})
  end
  return ret
end)()

return {
  "nvim-mini/mini.nvim",
  lazy = false,
  keys = keys,
  setup = setup,
}
