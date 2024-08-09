local function base_capabilities()
  return vim.tbl_deep_extend(
    "force",
    require("lspconfig").util.default_config.capabilities,
    require("cmp_nvim_lsp").default_capabilities()
  )
end

-- default, shared server settings
local base_opts = {
  capabilities = base_capabilities(),
}

local function config(server_name)
  local res, server = pcall(require, "mudox.lsp.backend.server." .. server_name)
  if not res then
    server = {}
  end

  if server.setup then
    -- in case the language/server has its own setup flow, e.g. rust-tools, typescript-tools ...
    if server.setup() then
      -- returning `true` skips `lspconfig[server].setup`
      return
    end
  end

  local opts = vim.tbl_deep_extend("force", base_opts, server.opts or {})
  require("lspconfig")[server_name].setup(opts)
end

local function setup_servers()
  -- when `require("mason-lspconfig").setup` is called, all servers installed by mason would be
  -- configured by mason-lspconfig with proper function from its `setup.handlers`
  -- those server that are not installed by mason need to be setup manually here by call `config_server`
  -- explicitly
  --
  -- under folder `backend/server/`, `xxx.lua` file provides custom server settings for given server
  -- named `xxx`
  -- if a server is not installed by mason, which means mason-lspconfig will not configure it
  -- automatically, set `mason = false` to manually setup here

  -- for servers can not be installed by mason, e.g. sourcekit-lsp
  local manually = {}
  -- for servers installed by mason
  local by_mason = {}
  for name, _ in vim.fs.dir("~/.config/nvim/lua/mudox/lsp/backend/server") do
    if name:sub(-4) == ".lua" then
      local server_name = name:sub(1, -5)
      local server = require("mudox.lsp.backend.server." .. server_name)

      if server.mason == false then
        table.insert(manually, server_name)
      else
        table.insert(by_mason, server_name)
      end
    end
  end

  -- for servers installed by mason, but need to be configured by other plugins, use `skip` function to
  -- skip config here. E.g. typescript-tools, rustaceanvim ...
  local function skip() end

  -- `setup` would IMMEDIATELY setup every installled server with handler found from `handlers`
  require("mason-lspconfig").setup {
    ensure_installed = by_mason,

    -- stylua: ignore
    handlers = {
      config, -- default setup handler for all servers installed by mason

      -- Note: set `skip` to servers that will be setup by other plugins
      ["rust_analyzer"] = skip,
    },
  }

  for _, server_name in ipairs(manually) do
    config(server_name)
  end
end

local function on_lsp_attach()
  -- U.on.lsp_attach(function(client, bufnr)
  -- local ft = vim.bo[bufnr].filetype

  -- if ft == "lua" then
  -- disable lsp syntax highlighting
  -- client.server_capabilities.semanticTokensProvider = nil
  -- end
  -- end)
end

local function setup()
  -- Order matters
  require("mason")
  setup_servers()
  on_lsp_attach()
end

return {
  setup = setup,
}
