local lsp = require("mudox.lsp")
local installer = require("nvim-lsp-installer")
local handler = require("mudox.lsp.handler")

lsp.setup()

installer.on_server_ready(function(server)
  local opts = {
    on_attach = handler.on_attach,
    capabilities = handler.capabilities,
  }

  local function extend(lhs, rhs)
    return vim.tbl_deep_extend("force", lhs, rhs)
  end

  if server.name == "sumneko_lua" then
    local sumneko_opts = require("mudox.lsp.server.sumneko_lua")
    opts = extend(sumneko_opts, opts)
  elseif server.name == "jsonls" then
    local jsonls_opts = require("mudox.lsp.server.jsonls")
    opts = extend(jsonls_opts, opts)
  elseif server.name == "rust_analyzer" then
    require("mudox.lsp.rust").setup_server(server, opts)
    return
  end

  server:setup(opts)
end)
