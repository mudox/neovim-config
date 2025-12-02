local function config()
  require("codeium").setup {}
end

return {
  "Exafunction/codeium.nvim",
  dependencies = { "plenary.nvim", "nvim-cmp" },
  event = "InsertEnter",
  cmd = "Codeium",
  config = config,
}
