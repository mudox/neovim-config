require("csvview").enable()

K.nmap("cos", function()
  require("csvview").toggle()
end, { buffer = true, desc = "[CsvView] Toggle" })
