local function r(name)
  return require("mudox.plugin.rust." .. name)
end

-- stylua: ignore
return {
  r "rustaceanvim",
  r "crates",
}
