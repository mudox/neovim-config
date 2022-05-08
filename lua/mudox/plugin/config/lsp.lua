local lsp = require("mudox.lsp")

local installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")

lsp.setup()

local servers = {
  -- Lua
  "sumneko_lua",

  -- JSON
  "jsonls",

  -- Rust
  "rust_analyzer",

  -- Swift
  "sourcekit",

  -- VimScript
  "vimls",

  -- Shell
  "bashls",

  -- Java
  "jdtls",

  -- WEB
  "html",
  "cssls",

  -- Python
  "pyright",
  "sourcery",

  -- JavaScript, TypeScript
  "tsserver",
}

installer.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local function setup(server)
  local opts = vim.deepcopy {
    on_attach = require("mudox.lsp.on_attach"),
    capabilities = capabilities,
  }

  local ok, custom_opts = pcall(require, "mudox.lsp.server." .. server)
  if ok then
    opts = vim.tbl_deep_extend("force", opts, custom_opts)
  end

  lspconfig[server].setup(opts)
end

for _, server in ipairs(servers) do
  setup(server)
end
