local M = {}

local function diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end

local keys = (function()
  local format = require("mudox.plugin.lsp.formatting").format

  return {
    -- diagnostic
    { "gl", vim.diagnostic.open_float, desc = "Line Diagnostics" },

    -- goto d|D|td|i|r
    { "gd", "<Cmd>Telescope lsp_definitions<Cr>", desc = "Goto Definition" },
    { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
    { "gt", "<Cmd>Telescope lsp_type_definitions<Cr>", desc = "Goto Type Definitions" },
    { "gI", "<Cmd>Telescope lsp_implementations<Cr>", desc = "Goto Implementations" },
    { "gr", "<Cmd>Telescope lsp_references<Cr>", desc = "Goto References" },

    -- help
    { "K", vim.lsp.buf.hover, desc = "Hover" },
    { "gk", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    { "<C-S-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },

    -- diagnostics
    { "]d", diagnostic_goto(true), desc = "Goto Next Issue" },
    { "[d", diagnostic_goto(false), desc = "Goto Previous Issue" },
    { "]D", diagnostic_goto(true, "ERROR"), desc = "Goto Next Error" },
    { "[D", diagnostic_goto(false, "ERROR"), desc = "Goto Previous Error" },

    -- format
    { "\\f", format, desc = "Format Document", has = "documentFormatting" },
    { "\\f", format, desc = "Format Range", mode = "v", has = "documentRangeFormatting" },

    -- rename
    { "\\r", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
  }
end)()

function setup_code_navigation(client, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {}

  for _, value in ipairs(keys) do
    local keys = Keys.parse(value)
    if keys[2] == vim.NIL or keys[2] == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end

  for _, keys in pairs(keymaps) do
    if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
      local opts = Keys.opts(keys)
      ---@diagnostic disable-next-line: no-unknown
      opts.has = nil
      opts.silent = true
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
    end
  end
end

function M.setup()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("mdx_lsp_setup_code_navigation", { clear = true }),
    callback = setup_code_navigation,
  })
end
return M
