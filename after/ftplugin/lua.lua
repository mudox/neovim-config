local o = vim.opt_local
o.suffixesadd:prepend(".lua")
o.suffixesadd:prepend("init.lua")
o.path:prepend(vim.fn.stdpath("config") .. "/lua")

K.nmap(K.sc("r"), function()
  vim.cmd([[
  silent! write
  source %
  ]])
end, "source %")
