return {
  dir = "~/Git/neovim-plugins/lazy-help.nvim", -- HACK: fix helpview.txt multi-encodings issue
  ft = "lazy",
  init = function()
    vim.g.docs_path = vim.fs.joinpath(vim.fn.stdpath("cache"), "cached_docs")
    vim.opt.rtp:append(vim.g.docs_path)
  end,
}
