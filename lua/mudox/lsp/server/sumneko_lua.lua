return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "stdpath", "pl" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  },
}
