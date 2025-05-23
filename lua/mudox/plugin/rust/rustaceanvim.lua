local function config()
  local tools = {}
  local server = {}
  local dap = {}

  vim.g.rustaceanvim = {
    tools = tools,
    server = server,
    dap = dap,
  }
end

return {
  "mrcjkb/rustaceanvim",
  dependencies = { "nvim-dap" },
  ft = "rust",
  config = config,
}
