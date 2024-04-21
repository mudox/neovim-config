local d = vim.diagnostic

local function setup_signs()
  local i = require("mudox.ui.icon").diagnostics.nerd
  -- stylua: ignore
  local signs = {
    { "DiagnosticSignError", i.error },
    { "DiagnosticSignWarn",  i.warn },
    { "DiagnosticSignInfo",  i.info },
    { "DiagnosticSignHint",  i.hint },
  }

  for _, v in ipairs(signs) do
    vim.fn.sign_define(v[1], { texthl = v[1], text = v[2] })
  end
end

local function config()
  d.config {
    update_in_insert = false,

    severity_sort = true,

    signs = true,

    underline = {
      severity = d.severity.ERROR,
    },

    virtual_text = false,
    -- virtual_text = {
    --   severity = d.severity.WARN,
    --
    --   spacing = 4,
    --   prefix = " 󰅂 ",
    --   suffix = " ",
    -- },

    float = {
      source = "if_many",
      prefix = " ",
    },
  }
end

local function setup_keymaps(_, bufnr)
  local function jump(next, severity)
    local go = next and d.goto_next or d.goto_prev
    severity = severity and d.severity[severity] or nil
    return function()
      go { severity = severity }
    end
  end

  local jump_dirop = {
    name = "Diagnostic issue",
    next = jump(true),
    prev = jump(false),
  }

  local jump_error_dirop = {
    name = "Diagnostic error",
    next = jump(true, "ERROR"),
    prev = jump(false, "ERROR"),
  }

  local function toggle()
    local function notify(msg)
      vim.notify(msg, vim.log.levels.INFO, { title = "LSP" })
    end

    if d.is_disabled() then
      d.enable()
      notify("Diagnostic enabled")
    else
      d.disable()
      notify("Diagnostic disabled")
    end
  end

  local function lsp_lines()
    require("lsp_lines").toggle()
  end

  local dirop = X.dirop.wrap

  -- stylua: ignore
  local keys = {
    ["]d"]  = { dirop(jump_dirop, 'next'),        "[Diagnostic] Next issue"     },
    ["[d"]  = { dirop(jump_dirop, 'prev'),        "[Diagnostic] Previous issue" },
    ["]E"]  = { dirop(jump_error_dirop, 'next'),  "[Diagnostic] Next error"     },
    ["[E"]  = { dirop(jump_error_dirop, 'prev'),  "[Diagnostic] Previous error" },

    ["gl"]  = { d.open_float,              "[Diagnostic] Show issue(s)" },
    ["col"] = { lsp_lines,                 "[Lsp Lines] Toggle" },

    ["yod"] = { toggle,                    "[Diagnostic] Toggle" },

    ["gQ"]  = { vim.diagnostic.setloclist, "[Diagnostic] Set loclist" },
  }

  require("which-key").register(keys, { buffer = bufnr })
end

local function setup()
  config()
  setup_signs()

  U.on.lsp_attach(setup_keymaps)
end

return {
  setup = setup,
}
