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

---Toggle nvim options with `:set {opt}!`
local function yo(k, o)
  return {
    "yo" .. k,
    "<Cmd>set " .. o .. "!<Bar>set " .. o .. "?<Cr>",
    desc = o .. "!",
  }
end

-- stylua: ignore
return {
  { "yo", group = "nvim toggle" },

  yo("h", "hlsearch"),
  yo("l", "list"),
  yo("n", "number"),
  yo("r", "relativenumber"),
  yo("s", "spell"),
  yo("w", "wrap"),

  { "yot", toggle_treesitter_highlighting, desc = "treesitter highlighting" },

  { "yoq", toggle_quickfix,                desc = "quickfix"                },
  { "yoL", toggle_loclist,                 desc = "loclist"                 },

  { "co", group = "plugin toggle" },
}
