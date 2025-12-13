local M = {
  -- stylua: ignore
  base = {
    ["."] = { path = ".nvim.lua",   desc = ".nvim.lua"   },
    [","] = { path = ".files.json", desc = ".files.json" },
  },
}

function M:reload()
  local ok, lines = pcall(vim.fn.readfile, ".files.json")
  if not ok then
    self.final = self.base
    return
  end

  local text = table.concat(lines, "\n")
  local ok, spec = pcall(vim.json.decode, text)
  if not ok then
    vim.fn.echoerr("[files] json decoding failed. " .. spec)
    self.final = self.base
  else
    self.final = vim.tbl_extend("keep", spec, self.base)
  end
end

function M:init()
  self:reload()

  -- stylua: ignore
  for key, v in pairs(self.final) do
    K.ncmd(K.s("e" .. key), "edit " .. v.path, v.desc)
    K.nmap(K.s("e[" .. key), function() X.layout.main:open(v.path) end)
    K.nmap(K.s("e]" .. key), function() X.layout.secondary:open(v.path) end)
  end
end

return M
