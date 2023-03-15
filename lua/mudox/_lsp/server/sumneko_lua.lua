if vim.env.MDX_NO_NVIM_LUA == "yes" then
  return {}
else
  -- Configure sumneko for Neovim API
  require("packer").loader("lua-dev.nvim")
  local opts = require("lua-dev").setup {}
  return opts
end
