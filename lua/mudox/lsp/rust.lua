local function dap_config()
  local extension_path = vim.fn.expand("~/.vscode/extensions/vadimcn.vscode-lldb-*")

  local codelldb_path = extension_path .. "/adapter/codelldb"
  assert(pl.path.isfile(codelldb_path))

  local liblldb_path = extension_path .. "/lldb/lib/liblldb.dylib"
  assert(pl.path.isfile(liblldb_path))

  return {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
  }
end

local function setup_server(server, opts)
  -- Initialize the LSP via rust-tools instead
  require("rust-tools").setup {
    -- The "server" property provided in rust-tools setup function are the
    -- settings rust-tools will provide to lspconfig during init.
    --
    -- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
    -- with the user's own settings (opts) here.
    server = vim.tbl_deep_extend("force", server:get_default_options(), opts),

    dap = dap_config(),
  }

  server:attach_buffers()

  -- Only if standalone support is needed
  -- require("rust-tools").start_standalone_if_required()
end

return {
  setup_server = setup_server,
}
