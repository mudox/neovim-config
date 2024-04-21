-- stylua: ignore
return {
  name = "lab",

  r = { function() require("mudox.lab.rootdir").info() end, "Root dir" },
  c = { function() require("mudox.lab.close").window() end, "Close window" },
}
