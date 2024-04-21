-- stylua: ignore
local function t(o) return { "<Cmd>set " .. o .. "!<Bar>set " .. o .. "?<Cr>", "[Option] " .. o } end

local function toggle_treesitter_highlighting()
  local function notify(msg)
    vim.notify(msg, vim.log.levels.INFO, { title = "TreeSitter" })
  end

  -- `b:ts_highlight` will be set automatically by `vim.treesitter.[start|stop]`

  if vim.b.ts_highlight then
    vim.treesitter.stop()
    notify("Highlighting is disabled")
  else
    vim.treesitter.start()
    notify("Highlighting is enabled")
  end
end

local function toggle_quickfix()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      vim.cmd("cclose")
      return
    end
  end
  vim.cmd("copen")
end

local function toggle_loclist()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["loclist"] == 1 then
      vim.cmd("lclose")
      return
    end
  end
  if not vim.tbl_isempty(vim.fn.getloclist(0)) then
    vim.cmd("lopen")
  else
    print("loclist is empty")
  end
end

-- stylua: ignore
local nvim = {
  name = "+nvim toggle",

  h = t "hlsearch",
  l = t "list",
  n = t "number",
  r = t "relativenumber",
  s = t "spell",
  w = t "wrap",

  t = { toggle_treesitter_highlighting, "treesitter highlighting" },

  q = { toggle_quickfix,                "quickfix"                },
  L = { toggle_loclist,                 "loclist"                 },
}

local plugin = {
  name = "+plugin toggle",
}

return {
  nvim = nvim,
  plugin = plugin,
}
