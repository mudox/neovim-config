-- stylua: ignore
local function r(name) return require("mudox.plugin.test." .. name) end

-- stylua: ignore
return {
  r "neotest"
}
