local lsp = require("mudox.lsp")

local mason = require("mason")
local mason_lsp = require("mason-lspconfig")

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

mason.setup()

mason_lsp.setup {
  ensure_installed = servers,
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

  require("lspconfig")[server].setup(opts)
end

local handlers = {
  setup, -- fallback
  -- ["rust_analyzer"] = function ()
  --     require("rust-tools").setup {}
  -- end
}

mason_lsp.setup_handlers(handlers)

-- NOTE: mason does not support sourcekit-lsp yet
setup("sourcekit")
