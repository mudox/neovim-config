return {
  "vhyrro/luarocks.nvim",
  lazy = false,
  priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
  opts = {
    rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
  },
  cond = false, -- currently notably increase neovim startup time, and cause flickring
}
