local d = vim.diagnostic

local function toggle_virtual_lines()
  local flag = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config { virtual_lines = flag }
end

local function config()
  local signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = I.short_bar,
      [vim.diagnostic.severity.WARN] = I.short_bar,
      [vim.diagnostic.severity.INFO] = I.short_bar,
      [vim.diagnostic.severity.HINT] = I.short_bar,
    },
  }

  local float = {
    source = true,
    prefix = I.short_bar .. " ",
  }

  d.config {
    underline = {
      severity = d.severity.ERROR,
    },
    update_in_insert = false,
    virtual_text = false, -- use tiny-inline-diagnostic.nvim instead
    virtual_lines = false,
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
      d.jump { count = count, severity = severity, float = false }
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

  local first_time = true

  local dirop = X.dirop.wrap

  -- stylua: ignore
  local keys = {
    -- Navigate
    { "]d",  dirop(jump_dirop, 'next'),       desc = "[Diagnostic] Next issue"     },
    { "[d",  dirop(jump_dirop, 'prev'),       desc = "[Diagnostic] Previous issue" },
    { "]E",  dirop(jump_error_dirop, 'next'), desc = "[Diagnostic] Next error"     },
    { "[E",  dirop(jump_error_dirop, 'prev'), desc = "[Diagnostic] Previous error" },

    -- View
    { "gl",  d.open_float,                    desc = "[Diagnostic] Show issue(s)"  },
    { "yol", toggle_virtual_lines,            desc = "Lsp Lines"                   },
    { "grq", vim.diagnostic.setloclist,       desc = "[Diagnostic] Set loclist"    },

    -- Toggle
    { "yod", toggle,                          desc = "[Diagnostic] Toggle"         },
  }

  require("which-key").add(keys, { buffer = bufnr })
end

local function setup()
  config()
  -- setup_signs()

  On.lsp_attach(setup_keymaps)
end

return {
  setup = setup,
}
