local disable_hl_ft = {
  tmux = true,
}

local function should_disable_hl()
  if disable_hl_ft[vim.bo.filetype] then
    return true
  end

  --- disable for big buffer
  local max_filesize = 50 * 1024 -- 50 KB
  local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(0))
  if ok and stats and stats.size > max_filesize then
    return true
  end

  return false
end

local function init()
  -- folding
  -- TODO: use ufo.nvim for perf
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.o.foldtext = "" -- use default transparent foldtext

  -- highlight
  vim.hl.priorities.semantic_tokens = 75 -- do not override treesitter highlighting
  On.FileType(function()
    if should_disable_hl() then
      print(("disable ts hl for %s"):format(vim.bo.filetype))
      vim.bo.syntax = "ON"
    else
      pcall(vim.treesitter.start)
    end
  end)

  -- indent
  vim.o.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    init = init,
    -- config = config,
  },
}
