local function capabilities()
  return vim.tbl_deep_extend(
    "force",
    require("lspconfig").util.default_config.capabilities,
    require("cmp_nvim_lsp").default_capabilities()
  )
end

-- default, shared server settings
local base_opts = {
  capabilities = capabilities(),
}

local function config_server(server_name)
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

local function setup_mason()
  require("mason").setup()
end

local function setup_neodev()
  require("neodev").setup {
    library = {
      -- PERF: list plugins only needed in `neovim-config` to reduce server initialization time and
      -- reduce memory overhead
      plugins = {
        "lazy.nvim",
        "nvim-treesitter",
        "plenary.nvim",
      },
    },
  }
end

local function on_attch()
  require("mudox.util.on").lsp_attach(function(client, bufnr)
    local ft = vim.bo[bufnr].filetype

    -- if ft == "lua" then
    -- disable lsp syntax highlighting
    -- client.server_capabilities.semanticTokensProvider = nil
    -- end
  end)
end

local function setup()
  -- Order matters
  -- 1. setup neodev
  -- 2. setup mason
  -- 3. setup mason-lspconfig
  -- 4. setup servers

  setup_neodev()

  setup_mason()

  local manually = {}
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

  local function skip() end

  -- `setup` would IMMEDIATELY setup every installled server with handler found from `handlers`
  require("mason-lspconfig").setup {
    ensure_installed = by_mason,

    -- stylua: ignore
    handlers = {
      config_server,

      -- Note: set `skip` to servers that will be setup by other plugins
      ["rust_analyzer"] = skip,
    },
  }

  for _, server_name in ipairs(manually) do
    config_server(server_name)
  end

  on_attch()
end

return {
  setup = setup,
}
