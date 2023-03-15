local dependencies = {
  { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
  { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
  "mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "hrsh7th/cmp-nvim-lsp",
    cond = function()
      return require("mudox.lib.lazy").has("nvim-cmp")
    end,
  },
}

---@class PluginLspOpts
local opts = {
  -- options for vim.diagnostic.config()
  diagnostics = {
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
  },
  -- Automatically format on save
  autoformat = true,
  -- options for vim.lsp.buf.format
  -- `bufnr` and `filter` is handled by the LazyVim formatter,
  -- but can be also overridden when specified
  format = {
    formatting_options = nil,
    timeout_ms = nil,
  },
  -- LSP Server Settings
  ---@type lspconfig.options
  servers = {
    jsonls = {},
    lua_ls = {
      -- mason = false, -- set to false if you don't want this server to be installed with mason
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    },
  },
  -- you can do any additional lsp server setup here
  -- return true if you don't want this server to be setup with lspconfig
  ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
  setup = {
    -- example to setup with typescript.nvim
    -- tsserver = function(_, opts)
    --   require("typescript").setup({ server = opts })
    --   return true
    -- end,
    -- Specify * to use this function as a fallback for any server
    -- ["*"] = function(server, opts) end,
  },
}

local function setup_formatting()
  -- setup autoformat
  require("mudox.plugin.lsp.format").autoformat = opts.autoformat
  -- setup formatting and keymaps
  require("mudox.lib").on_attach(function(client, buffer)
    require("mudox.plugin.lsp.format").on_attach(client, buffer)
    require("mudox.plugin.lsp.keymaps").on_attach(client, buffer)
  end)
end

local function setup_signs()
  local i = require("mudox.ui").icons
  local signs = {
    { name = "DiagnosticSignError", text = i.error },
    { name = "DiagnosticSignWarn", text = i.warn },
    { name = "DiagnosticSignInfo", text = i.info },
    { name = "DiagnosticSignHint", text = i.hint },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text })
  end
end

---@param opts PluginLspOpts
local function config(plugin, opts)
  setup_formatting()
  setup_signs()

  local servers = opts.servers
  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

  local function setup(server)
    local server_opts = vim.tbl_deep_extend("force", {
      capabilities = vim.deepcopy(capabilities),
    }, servers[server] or {})

    if opts.setup[server] then
      if opts.setup[server](server, server_opts) then
        return
      end
    elseif opts.setup["*"] then
      if opts.setup["*"](server, server_opts) then
        return
      end
    end

    require("lspconfig")[server].setup(server_opts)
  end

  -- temp fix for lspconfig rename
  -- https://github.com/neovim/nvim-lspconfig/pull/2439
  local mappings = require("mason-lspconfig.mappings.server")
  if not mappings.lspconfig_to_package.lua_ls then
    mappings.lspconfig_to_package.lua_ls = "lua-language-server"
    mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
  end

  local mlsp = require("mason-lspconfig")
  local available = mlsp.get_available_servers()

  local ensure_installed = {} ---@type string[]
  for server, server_opts in pairs(servers) do
    if server_opts then
      server_opts = server_opts == true and {} or server_opts
      -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
      if server_opts.mason == false or not vim.tbl_contains(available, server) then
        setup(server)
      else
        ensure_installed[#ensure_installed + 1] = server
      end
    end
  end

  require("mason-lspconfig").setup { ensure_installed = ensure_installed }
  require("mason-lspconfig").setup_handlers { setup }
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = dependencies,
  opts = opts,
  config = config,
}
