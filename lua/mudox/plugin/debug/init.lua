-- stylua: ignore
local function r(name) return require("mudox.plugin.debug." .. name) end

-- stylua: ignore
-- for loading language adapters
local function a(name) return require("mudox.plugin.debug.lang." .. name).adapter end

-- stylua: ignore
return {
  -- Core
  r "dap",

  -- UI
  r "dap-ui",
  r "dap-virtual-text",

  -- Adapters
  a "neovim_lua",
  a "python",
}
