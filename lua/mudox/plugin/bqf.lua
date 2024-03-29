local opts = {
  func_map = { split = "<C-s>" },
  preview = {
    border = "single",
  },
}

local function config()
  require("bqf").setup(opts)
  vim.api.nvim_set_hl(0, "BqfPreviewBorder", { bg = "bg" })
end

return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  config = config,
}
