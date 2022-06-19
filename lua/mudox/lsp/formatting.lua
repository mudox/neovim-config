local clients = {
  tsserver = true,
  sumneko_lua = true,
}

-- For instant formatting
local function sync()
  local enabled_filetypes = {
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

local function on_save(client, bufnr)
  if not client.server_capabilities.documentFormattingProvider then
    return
  end

  local gid = vim.api.nvim_create_augroup("MudoxLspFormatOnSave", { clear = true })

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
