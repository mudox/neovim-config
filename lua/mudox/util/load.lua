return function(name)
  -- shared
  require("mudox." .. name)

  -- mode specific
  local path = ("%s/lua/mudox/%s/%s.lua"):format(vim.fn.stdpath("config"), vim.g.mdx_nvim_mode, name)
  if vim.fn.filereadable(path) == 1 then
    require(("mudox.%s.%s"):format(vim.g.mdx_nvim_mode, name))
  end
end
