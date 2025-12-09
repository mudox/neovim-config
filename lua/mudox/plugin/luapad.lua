local function pad()
  vim.cmd("Luapad")

  local opts = { buffer = true, remap = false, nowait = true }
  K.nmap("q", "ZQ", opts)
  K.nmap("<Bs>b", "ZQ", opts)
  K.nmap("<Bs>x", "ZQ", opts)
end

return {
  "rafcamlet/nvim-luapad",
  cmd = { "LuaRun", "Luapad" },
  keys = { { K.p("v="), pad, desc = "luadpad" } },
  opts = true,
}
