local clients = {
  tsserver = false,
  sumneko_lua = false,

  ["null-ls"] = true,
}

-- For instant formatting
local function sync()
  local enabled_filetypes = {
    html = true,
    javascript = true,
    css = true,
    lua = true,
    swift = true,
  }

  if enabled_filetypes[vim.o.ft] then
    vim.lsp.buf.format {
      async = false,
      filter = function(client)
        return clients[client.name]
      end,
    }
  end
end

--- For slow formatting
local function async()
  local enabled_filetypes = {
    python = true,
  }

  if enabled_filetypes[vim.o.ft] then
    vim.lsp.buf.format {
      async = true,
      filter = function(client)
        return clients[client.name]
      end,
    }
  end
end

local gid = vim.api.nvim_create_augroup("MudoxLspFormatOnSave", {})

-- Add to LSP client `on_attach` function body
local function on_save(client, bufnr)
  if not client.supports_method("textDocument/formatting") then
    return
  end

  vim.api.nvim_clear_autocmds { group = gid, buffer = bufnr }

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = gid,
    buffer = bufnr,
    callback = sync,
  })

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = gid,
    buffer = bufnr,
    callback = async,
  })
end

return {
  on_save = on_save,
  sync = sync,
  async = async,
}
