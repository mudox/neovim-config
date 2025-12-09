local disable_hl_fts = {
  tmux = true,
}

local function should_disable_hl()
  if disable_hl_fts[vim.bo.filetype] then
    return true
  end

  --- disable for big buffer
  local max_filesize = 50 * 1024
  local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(0))
  if ok and stats and stats.size > max_filesize then
    print(("file size (%d) is too larg, disable treesitter highlighting"):format(stats.size))
    return true
  end

  return false
end

local function init()
  -- folding
  if not V.ufo then
    vim.o.foldcolumn = "1"
    vim.o.foldmethod = "expr"
    vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    -- vim.o.foldtext = "" -- use default transparent foldtext
    vim.o.foldtext = "v:lua.require('ufo.main').foldtext()"
  end

  -- highlight
  On.FileType(function()
    if not should_disable_hl() then
      pcall(vim.treesitter.start)
    else
      pcall(vim.treesitter.stop)
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
