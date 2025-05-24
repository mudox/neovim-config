local function r(name)
  return require("mudox.plugin.javascript." .. name)
end

-- stylua: ignore
return {
  r"typescript-tools"
}
