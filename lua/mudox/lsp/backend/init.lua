local M = {}

local function capabilities()
  return vim.tbl_deep_extend(
    "force",
    require("lspconfig").util.default_config.capabilities,
    require("cmp_nvim_lsp").default_capabilities()
  )
end

local function setup_mason() end

function M.setup()
  -- default, shared server settings
  local base = {
    capabilities = capabilities(),
  }

  local function config_server(server_name)
    local res, server = pcall(require, "mudox.plugin.lsp.server." .. server_name)
    if not res then
      vim.notify(("spec file for server %s is not found"):format(server_name), vim.log.levels.WARN)
      return
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

  local mason_lspconfig = require("mason-lspconfig")
  local servers = mason_lspconfig.get_available_servers()
  local servers_setup_by_mason = {}

  for name, type in vim.fs.dir("~/.config/nvim/lua/mudox/lsp/backend/server") do
    if type == "file" and name:sub(-4) == ".lua" then
      local server_name = name:sub(1, -5)
      local server = require("mudox.plugin.lsp.server." .. server_name)

      if server.mason == false or not vim.tbl_contains(servers, server) then
        config_server(server_name)
      else
        table.insert(servers_setup_by_mason, server_name)
      end
    end
  end

  -- NOTE: order matters
  -- 1. setup mason
  -- 2. setup mason-lspconfig
  -- 3. lspconfig[server].setup { ... }

  setup_mason()
  mason_lspconfig.setup {
    ensure_installed = servers_setup_by_mason,
    handlers = { config_server },
  }
end

return M
