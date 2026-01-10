local SPECFILE = ".files.csv"

---open ftplugin/{ft}.lua
---@param open fun(path: string) function to open file
local function open_ft(open)
  local o = vim.bo.filetype
  if not o or o == "" then
    vim.notify("[files] current buffer has no filetype", vim.log.levels.WARN)
    return
  end

  local fts = vim.split(o, ".", { plain = true })

  local function make_path(ft)
    local base = vim.fn.stdpath("config") .. "/after/ftplugin/"
    return base .. ft .. ".lua"
  end

  if #fts == 1 then
    open(make_path(fts[1]))
  else
    vim.ui.select(fts, {
      prompt = "Select filetype to open",
    }, function(ft)
      if ft then
        open(make_path(ft))
      end
    end)
  end
end

local function edit(path)
  return function()
    U.window.close_all_floats()
    require("edgy").goto_main()
    vim.cmd.edit(path)
  end
end
local function main_open(path)
  return function()
    U.window.close_all_floats()
    X.layout.left:open(path)
  end
end
local function secondary_open(path)
  return function()
    U.window.close_all_floats()
    X.layout.right:open(path)
  end
end
local function tab_open(path)
  return function()
    vim.cmd.tabnew(path)
  end
end

local M = {
  base = {
    ["."] = { path = ".nvim.lua", desc = ".nvim.lua" },
    [","] = { path = ".files.csv", desc = ".files.csv" },
  },
}

function M.read()
  local ok, lines = pcall(io.lines, SPECFILE)
  if not ok then
    return
  end
  return vim.iter(lines):fold({}, function(acc, line)
    local key, path, desc = unpack(vim.split(line, ","))
    acc[key] = { path = path, desc = desc }
    return acc
  end)
end

function M:reload()
  self.final = self.base

  local ok, spec = pcall(self.read)
  if not ok then
    print("[files] read spec file failed. " .. spec)
  elseif spec == nil then
    -- no spec file found
  else
    self.final = vim.tbl_extend("keep", spec, self.base)
  end
end

function M:update_keymaps()
  for key, v in pairs(self.final) do
    -- stylua: ignore start
    K.nmap(K.s("e" .. key),      edit(v.path),           v.desc)
    K.nmap(K.s("e[" .. key),     main_open(v.path),      v.desc)
    K.nmap(K.s("e]" .. key),     secondary_open(v.path), v.desc)
    K.nmap(K.s("e<Tab>" .. key), tab_open(v.path),       v.desc)
    -- stylua: ignore end
  end

  -- stylua: ignore start
  K.nmap(K.s("e;"),      function() open_ft(function(path) edit(path)() end) end,           "{ft}.lua")
  K.nmap(K.s("e[;"),     function() open_ft(function(path) main_open(path)() end) end,      "{ft}.lua")
  K.nmap(K.s("e];"),     function() open_ft(function(path) secondary_open(path)() end) end, "{ft}.lua")
  K.nmap(K.s("e<Tab>;"), function() open_ft(function(path) tab_open(path)() end) end,       "{ft}.lua")
  -- stylua: ignore end
end

function M:init()
  self:reload()
  self:update_keymaps()

  On.BufWritePost(function()
    self:reload()
    self:update_keymaps()
  end, { pattern = SPECFILE, group = V.ag.files })
end

return M
