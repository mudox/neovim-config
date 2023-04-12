local function diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end

local keys = nil

local function get()
  local format = require("mudox.plugin.lsp.format").format
  if not keys then

    -- stylua: ignore start
    keys =  {
      { "<leader>ci", "<Cmd>LspInfo<Cr>", desc = "Lsp Info" },

      -- diagnostic
      { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },

      -- goto
      { "gd", "<Cmd>Telescope lsp_definitions<Cr>", desc = "Goto Definition" },
      { "gr", "<Cmd>Telescope lsp_references<Cr>", desc = "References" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "gI", "<Cmd>Telescope lsp_implementations<Cr>", desc = "Goto Implementation" },
      { "gt", "<Cmd>Telescope lsp_type_definitions<Cr>", desc = "Goto Type Definition" },

      -- help
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
      { "<C-S-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },

      -- diagnostics
      { "]d", diagnostic_goto(true), desc = "Next Diagnostic" },
      { "[d", diagnostic_goto(false), desc = "Prev Diagnostic" },
      { "]x", diagnostic_goto(true, "ERROR"), desc = "Next Error" },
      { "[x", diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
      { "]w", diagnostic_goto(true, "WARN"), desc = "Next Warning" },
      { "[w", diagnostic_goto(false, "WARN"), desc = "Prev Warning" },

      -- code action
      -- { "\\a", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
      -- Currently use plugin 'actions-preview'

      -- format
      { "\\f", format, desc = "Format Document", has = "documentFormatting" },
      { "\\f", format, desc = "Format Range", mode = "v", has = "documentRangeFormatting" },
    }
    -- stylua: ignore end

    if require("mudox.lib.lazy").has("inc-rename.nvim") then
      keys[#keys + 1] = {
        "<leader>cr",
        function()
          require("inc_rename")
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Rename",
        has = "rename",
      }
    else
      keys[#keys + 1] = { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
    end
  end

  return keys
end

function on_attach(client, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {}

  for _, value in ipairs(get()) do
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

return {
  on_attach = on_attach,
}
