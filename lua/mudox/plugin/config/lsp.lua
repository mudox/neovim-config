local lsp = require("mudox.lsp")

local installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")

lsp.setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("mudox.lsp.on_attach"),
    capabilities = capabilities,
  }

  local function extend(lhs, rhs)
    return vim.tbl_deep_extend("force", lhs, rhs)
  end

  if server.name == "sumneko_lua" then
    -- Lua
    local sumneko_opts = require("mudox.lsp.server.sumneko_lua")
    opts = extend(sumneko_opts, opts)
  elseif server.name == "jsonls" then
    -- JSON
    local jsonls_opts = require("mudox.lsp.server.jsonls")
    opts = extend(jsonls_opts, opts)
  elseif server.name == "rust_analyzer" then
    -- Rust
    require("mudox.lsp.rust").setup_server(server, opts)
    return
  end

  server:setup(opts)
end)
