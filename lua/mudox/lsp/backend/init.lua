local M = {}

local function capabilities()
  return vim.tbl_deep_extend(
    "force",
    require("lspconfig").util.default_config.capabilities,
    require("cmp_nvim_lsp").default_capabilities()
  )
end

-- default, shared server settings
local base = {
  capabilities = capabilities(),
}

local function config_server(server_name)
  local res, server = pcall(require, "mudox.lsp.backend.server." .. server_name)
  if not res then
    server = {}
  end

  if server.setup then
    if server.setup() then
      -- returning `true` skips `lspconfig[server].setup`
      return
    end
  end

  local opts = vim.tbl_deep_extend("force", base, server.opts or {})
  require("lspconfig")[server_name].setup(opts)
end

local function setup_mason()
  require("mason").setup()
end

local function setup_neodev()
  require("neodev").setup {}
end

function M.setup()
  -- NOTE: order matters
  -- 1. setup neodev
  -- 2. setup mason
  -- 3. setup mason-lspconfig
  -- 4. lspconfig[server].setup { ... }

  setup_neodev()
  setup_mason()

  local manually = {}
  local by_mason = {}
  for name, _ in vim.fs.dir("~/.config/nvim/lua/mudox/lsp/backend/server") do
    local server_name = name:sub(1, -5)
    local server = require("mudox.lsp.backend.server." .. server_name)

    if server.mason == false then
      table.insert(manually, server_name)
    else
      table.insert(by_mason, server_name)
    end
  end

  require("mason-lspconfig").setup {
    ensure_installed = by_mason,
    handlers = { config_server },
  }

  for _, server_name in ipairs(manually) do
    config_server(server_name)
  end
end

return M
