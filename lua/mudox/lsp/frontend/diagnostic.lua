local d = vim.diagnostic

local function config()
  local E = vim.diagnostic.severity.ERROR
  local W = vim.diagnostic.severity.WARN
  local I = vim.diagnostic.severity.INFO
  local H = vim.diagnostic.severity.HINT
  local bar = require("mudox.ui.icon").bar
  local signs = {
    text = {
      [E] = bar,
      [W] = bar,
      [I] = bar,
      [H] = bar,
    },
  }

  local float = {
    source = "if_many",
    prefix = " ",
  }

  d.config {
    underline = {
      severity = d.severity.ERROR,
    },
    -- virtual_text = true,
    update_in_insert = false,
    severity_sort = true,
    signs = signs,
    float = float,
  }
end

local function setup_keymaps(_, bufnr)
  local function jump(next, severity)
    local count = next and 1 or -1
    severity = severity and d.severity[severity] or nil
    return function()
      d.jump { count = count, severity = severity }
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
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    local enabled = d.is_enabled() and "enabled" or "disabled"
    vim.notify("Diagnostic is " .. enabled, vim.log.levels.INFO, { title = "LSP" })
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
  -- setup_signs()

  U.on.lsp_attach(setup_keymaps)
end

return {
  setup = setup,
}
