local disable_hl_fts = {
  tmux = true,
  csv = true,
}

local function should_disable_hl()
  if disable_hl_fts[vim.bo.filetype] then
    return true
  end

  --- disable for big buffer
  local max_filesize = 500 * 1024
  local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(0))
  if ok and stats and stats.size > max_filesize then
    print(("file size (%d) is too larg, disable treesitter highlighting"):format(stats.size))
    return true
  end

  return false
end

local function config()
  local ts = require("nvim-treesitter")

  -- ensure installed
  -- stylua: ignore
  ts.install {
    -- shell
    "bash", "zsh", "nu",

    -- git
    "diff", "git_config", "git_rebase", "gitcommit", "gitignore",

    -- markdown
    "markdown", "markdown_inline",

    -- web
    "html",
    "css", "scss",
    "javascript", "typescript", "tsx",
    "vue", "svelte",

    -- data
    "json", "toml", "yaml", "xml",

    -- neovim
    "lua", "luadoc", "vim", "vimdoc",

    -- major languages
    "python", "rust", "swift", "zig",

    -- pattern
    "query", "regex",

    -- other
    "comment",
    "make",
  }

  -- highlight
  On.FileType(nil, function(ev)
    -- highlighting
    if not should_disable_hl() then
      pcall(vim.treesitter.start)
    else
      pcall(vim.treesitter.stop)
    end

    -- indent
    local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
    if vim.treesitter.query.get(lang, "indents") then
      vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
    end
  end)

  -- folding
  -- if not V.ufo then
  --   vim.o.foldcolumn = "1"
  --   vim.o.foldmethod = "expr"
  --   vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  --   -- vim.o.foldtext = "" -- use default transparent foldtext
  --   vim.o.foldtext = "v:lua.require('ufo.main').foldtext()"
  -- end
end

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = config,
}
