local function highlight_cursor(client, bufnr)
  if not client.server_capabilities.documentHighlightProvider then
    return
  end

  local gid = vim.api.nvim_create_augroup("MudoxLspHighlightCursor", { clear = true })

  -- NOTE: related plugin `FixCursorHold`

  vim.api.nvim_create_autocmd("CursorHold", {
    group = gid,
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = gid,
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end

local clients_to_disable = { tsserver = true, sumneko_lua = true }

-- For instant formatting
local function format_document_sync()
  local enabled_filetypes = {
    lua = true,
    swift = true,
  }

  if enabled_filetypes[vim.o.ft] then
    vim.lsp.buf.format {
      async = false,
      filter = function(clients)
        return vim.tbl_filter(function(client)
          return clients_to_disable[client.name] == nil
        end, clients)
      end,
    }
  end
end

--- For slow formatting
local function format_document_async()
  local enabled_filetypes = {
    python = true,
  }

  if enabled_filetypes[vim.o.ft] then
    vim.lsp.buf.format {
      async = true,
      filter = function(clients)
        return vim.tbl_filter(function(client)
          return clients_to_disable[client.name] == nil
        end, clients)
      end,
    }
  end
end

local function format_on_save(client, bufnr)
  if not client.server_capabilities.documentFormattingProvider then
    return
  end

  local gid = vim.api.nvim_create_augroup("MudoxLspFormatOnSave", { clear = true })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = gid,
    buffer = bufnr,
    callback = format_document_sync,
  })

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = gid,
    buffer = bufnr,
    callback = format_document_async,
  })
end

local function lsp_mappings(bufnr)
  local nlua = function(key, cmd)
    local opts = { buffer = bufnr }
    require("mudox.keymap").nlua(key, cmd, opts)
  end
  local nmap = require("mudox.keymap").nmap

  -- goto
  nlua("gD", "vim.lsp.buf.declaration()")
  nlua("gd", "vim.lsp.buf.definition()")
  nlua("gT", "vim.lsp.buf.type_definition()")
  nlua("gi", "vim.lsp.buf.implementation()")
  nlua("gr", "vim.lsp.buf.references()")

  -- help
  nlua("gh", "vim.lsp.buf.hover()")
  nlua("gs", "vim.lsp.buf.signature_help()")

  -- refactor
  nlua("\\rn", "vim.lsp.buf.rename()")
  nlua("\\ca", "vim.lsp.buf.code_action()")
  nmap("\\fm", format_document_sync)

  -- diagnostics
  nlua("[d", "vim.diagnostic.goto_prev()")
  nlua("]d", "vim.diagnostic.goto_next()")
  nlua("gl", "vim.diagnostic.open_float()")
end
return function(client, bufnr)
  lsp_mappings(bufnr)
  highlight_cursor(client, bufnr)
  format_on_save(client, bufnr)

  require("aerial").on_attach(client, bufnr)
end
