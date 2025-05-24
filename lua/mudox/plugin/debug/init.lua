-- stylua: ignore start
local function r(name) return require("mudox.plugin.debug." .. name) end
local function a(name) return require("mudox.plugin.debug.lang." .. name).adapter end
-- stylua: ignore end

-- stylua: ignore
return {
  -- Core
  r"dap",

  -- UI
  r"dap-ui",
  r"dap-virtual-text",
  r"debugmaster",

  -- Adapters
  a"neovim_lua",
  a"python",
}
