local function dap_config()
  local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/"
  local codelldb_path = extension_path .. "adapter/codelldb"
  local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

  if not pl.path.isfile(codelldb_path) then
    vim.notify("codelldb path changed, skip rust-tools debugging configuration", "error", { title = "RUST-TOOLS" })
    return nil
  end

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
