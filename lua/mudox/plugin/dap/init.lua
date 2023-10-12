local function r(name)
  return require("mudox.plugin.dap." .. name)
end

return {
  r("dap"),

  r("dap-ui"),
  r("dap-virtual-text"),
}
