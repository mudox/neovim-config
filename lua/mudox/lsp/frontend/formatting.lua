local M = {}

-- stylua: ignore start
local config = {
  ft_server_map = {
    lua    = { "null-ls" },
    python = { "null-ls" },
    rust   = { "rust-analyzer" },
  }
}
-- stylua: ignore end

local format_opts = {
  filter = function(client)
    local servers = config.ft_server_map[vim.bo.filetype]
    if servers == nil then
      return client.name == "null-ls" -- use null-ls by default
    end

    return vim.tbl_contains(servers, client.name)
  end,
}

local function format()
  vim.lsp.buf.format(format_opts)
end

local function auto_format()
  local enabled = vim.b["mdx_lsp_autoformat"]
  if enabled == false then
    return
  end

  format()
end

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local function setup_format_on_save()
  local function on_lsp_attach(event)
    local bufnr = event.buf
    local group = "mdx_lsp_format_on_save"
    local group_id = augroup(group, { clear = true })

    vim.api.nvim_clear_autocmds { group = group, buffer = bufnr }
    autocmd("BufWritePre", {
      group = group_id,
      buffer = bufnr,
      desc = "LSP Format Buffer on Save",
      callback = auto_format,
    })
  end

  autocmd("LspAttach", {
    group = augroup("mdx_setup_lsp_format_on_save", { clear = true }),
    desc = "Setup LSP Format Buffer on Save",
    callback = on_lsp_attach,
  })
end

local function setup_format_on_key()
  autocmd("LspAttach", {
    group = augroup("mdx_setup_lsp_format_on_key", { clear = true }),
    desc = "Setup Format Buffer on Key (\\f)",
    callback = function(event)
      vim.keymap.set({ "n", "x" }, "\\f", format, { buffer = event.buf, desc = "LSP Format" })
    end,
  })
end

function M.setup()
  setup_format_on_save()
  setup_format_on_key()
end

function M.check(server)
  local bufnr = vim.api.nvim_get_current_buf()
  local client = vim.lsp.get_active_clients({ bufnr = bufnr, name = server })[1]

  if client == nil then
    local msg = "%s is not active"
    vim.notify(msg:format(server), vim.log.levels.WARN)
    return false
  end

  if vim.lsp.buf_is_attached(bufnr, client.id) == false then
    local msg = "%s is not active in the current buffer"
    vim.notify(msg:format(server), vim.log.levels.WARN)
    return false
  end

  if client.supports_method("textDocument/formatting") == false then
    local msg = "%s does not support `textDocument/formatting` method"
    vim.notify(msg:format(server), vim.log.levels.WARN)
    return false
  end

  -- local msg = "%s has formatting capabilities"
  -- vim.notify(msg:format(server))

  return true
end

return M
