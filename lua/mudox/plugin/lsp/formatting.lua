local Util = require("lazy.core.util")

local M = {}

M.autoformat = true

function M.toggle()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    M.autoformat = true
  else
    M.autoformat = not M.autoformat
  end
  if M.autoformat then
    Util.info("Enabled format on save", { title = "Format" })
  else
    Util.warn("Disabled format on save", { title = "Format" })
  end
end

function M.format()
  if vim.b.autoformat == false then
    return
  end

  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

  vim.lsp.buf.format(vim.tbl_deep_extend("force", {
    bufnr = buf,
    filter = function(client)
      if have_nls then
        return client.name == "null-ls"
      end
      return client.name ~= "null-ls"
    end,
  }, require("mudox.lib.lazy").get_opts("nvim-lspconfig").format or {}))
end

local function on_attach(client, buf)
  -- dont format if client disabled it
  if
    client.config
    and client.config.capabilities
    and client.config.capabilities.documentFormattingProvider == false
  then
    return
  end

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
      buffer = buf,
      callback = function()
        if M.autoformat then
          M.format()
        end
      end,
    })
  end
end

function M.setup()
  local gid = vim.api.nvim_create_augroup("mdx_lsp_setup_format_old", { clear = true })
  require("mudox.lib").on_lsp_attach(gid, on_attach)
end

function M.check(server)
  local bufnr = vim.api.nvim_get_current_buf()
  local client = vim.lsp.get_active_clients({ bufnr = bufnr, name = server })[1]

  if client == nil then
    local msg = "%s is not active"
    vim.notify(msg:format(server), vim.log.levels.WARN)
    return
  end

  if vim.lsp.buf_is_attached(bufnr, client.id) == false then
    local msg = "%s is not active in the current buffer"
    vim.notify(msg:format(server), vim.log.levels.WARN)
    return
  end

  if client.supports_method("textDocument/formatting") == false then
    local msg = "%s does not support textDocument/formatting method"
    vim.notify(msg:format(server), vim.log.levels.WARN)
    return
  end

  local msg = "%s has formatting capabilities"
  vim.notify(msg:format(server))
end

-- stylua: ignore start

local ft_server_map = {
  lua    = { "null-ls" },
  python = { "null-ls" },
  rust   = { "rust-analyzer" },
}

-- stylua: ignore end

local format_opts = {
  filter = function(client)
    local servers = ft_server_map[vim.bo.filetype]
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

function M.format_on_save()
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
    group = augroup("mdx_lsp_setup_format", { clear = true }),
    desc = "Setup LSP Format Buffer on Save",
    callback = on_lsp_attach,
  })
end

function M.format_on_key()
  local format_id = augroup("mdx_lsp_format_on_key", { clear = true })

  local on_lsp_attach = function(event)
    local desc = string.format("Format buffer with %s", client.name)

    vim.keymap.set({ "n", "x" }, "\\f", format, { buffer = event.buf, desc = desc })
  end

  autocmd("LspAttach", {
    group = format_id,
    desc = "Setup Format Buffer on Key (\\f)",
    callback = on_lsp_attach,
  })
end

return M
