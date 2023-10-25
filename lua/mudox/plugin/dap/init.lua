-- stylua: ignore
local function r(name) return require("mudox.plugin.dap." .. name) end

-- stylua: ignore
local function a(name) return require("mudox.plugin.dap.lang." .. name).adapter end

-- stylua: ignore
return {
  -- Core
  r "dap",

  -- UI
  r "dap-ui",
  r "dap-virtual-text",

  -- Adapters
  a "neovim_lua", -- Neovim lua
  a "python",
}
