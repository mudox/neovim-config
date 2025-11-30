local opts = {}

opts.ensure_installed = {
  "c",
  "lua",
  "vim",
  "vimdoc",
  "query",
}

-- tree-sitter-cli is installed by mason
opts.auto_install = true

opts.highlight = {
  enable = true,

  ---@diagnostic disable-next-line: unused-local
  disable = function(lang, buf)
    --- disable for big buffer
    local max_filesize = 50 * 1024 -- 50 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
    if ok and stats and stats.size > max_filesize then
      return true
    end
  end,
}

local function init()
  -- folding
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  vim.o.foldtext = "" -- use default transparent foldtext

  -- highlight
  vim.hl.priorities.semantic_tokens = 75 -- do not override treesitter highlighting
  On.FileType(function()
    pcall(vim.treesitter.start)
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
