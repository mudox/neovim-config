return {
  "phanen/lazy-help.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.docs_path = vim.fs.joinpath(vim.fn.stdpath("cache"), "cached_docs")
    vim.opt.rtp:append(vim.g.docs_path)
  end,
}
