vim.g.neoformat_basic_format_align = 1
vim.g.neoformat_basic_format_retab = 1
vim.g.neoformat_basic_format_trim = 1

vim.g.neoformat_enabled_python = { "black", "docformatter" }
vim.g.neoformat_enabled_lua = { "stylua" }
vim.g.neoformat_enabled_ruby = { "robocop" }

vim.g.neoformat_swift_swiftformat = {
  exe = "swiftformat",
  stdin = 1,
  args = {
    "--indent 2",
  },
}
