local opts = {
  enable = true,
  enable_autocmd = false,
}

return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  event = { "BufReadPre", "BufNewFile" },
  init = function()
    -- skip backwards compatibility routines and speed up loading
    vim.g.skip_ts_context_commentstring_module = true
  end,
  opts = opts,
}
