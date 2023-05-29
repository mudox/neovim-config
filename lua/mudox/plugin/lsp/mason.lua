local function config(_, opts)
  require("mason").setup(opts)

  local mr = require("mason-registry")
  for _, tool in ipairs(opts.ensure_installed) do
    local p = mr.get_package(tool)
    if not p:is_installed() then
      p:install()
    end
  end
end

local opts = {
  ensure_installed = {
    "stylua",
  },
}

return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  keys = { { "<leader>vm", "<Cmd>Mason<Cr>", desc = "Mason" } },
  opts = opts,
  config = config,
}
