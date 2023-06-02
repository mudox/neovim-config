local M = {}

local function setup_signs()
  local i = require("mudox.ui").icons
  -- stylua: ignore start
  local signs = {
    { "DiagnosticSignError", i.error },
    { "DiagnosticSignWarn",  i.warn },
    { "DiagnosticSignInfo",  i.info },
    { "DiagnosticSignHint",  i.hint },
  }
  -- stylua: ignore end

  for _, v in ipairs(signs) do
    vim.fn.sign_define(v[1], { texthl = v[1], text = v[2] })
  end
end

local function config()
  vim.diagnostic.config {
    update_in_insert = false,

    severity_sort = true,

    signs = true,

    underline = {
      severity = vim.diagnostic.severity.WARN,
    },

    virtual_text = {
      severity = vim.diagnostic.severity.WARN,
      spacing = 4,
      prefix = "󰅂",
    },

    float = {
      source = "always",
    },
  }
end

local function jump(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end

local function setup_keymaps(bufnr)
  local function b(t)
    t.buffer = bufnr
  end

  -- stylua: ignore start
  local keys = {
    ["]d"] = b { jump(true),            "Goto Next Issue" },
    ["[d"] = b { jump(false),           "Goto Previous Issue" },
    ["]E"] = b { jump(true, "ERROR"),   "Goto Next Error" },
    ["[E"] = b { jump(false, "ERROR"),  "Goto Previous Error" },

    ["gl"] = b { vim.diagnostic.open_float, "Show Issue(s) of Current Line" },

    -- TODO: show / hide, toggle diagnostic feature
  }
  -- stylua: ignore end

  require("which-key").register(keys)
end

local function setup_keymaps_on_attach()
  local gid = vim.api.nvim_create_augroup("mdx_lsp_setup_diagnostic_keymaps", { clear = true })
  vim.api.nvim_create_autocmd("LspAttach", {
    group = gid,
    desc = "Setup keymaps for LSP diagnostic",
    callback = function(event)
      setup_keymaps(event.buf)
    end,
  })
end

function M.setup()
  config()
  setup_signs()
  setup_keymaps_on_attach()
end

return M
