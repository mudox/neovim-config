local d = vim.diagnostic

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
    source = "if_many",
    prefix = I.short_bar .. " ",
  }

  local virtual_text = {
    severity = vim.diagnostic.severity.ERROR,
    prefix = "⎸",
    suffix = "",
    source = false,
  }

  d.config {
    underline = {
      severity = d.severity.ERROR,
    },
    update_in_insert = false,
    virtual_text = virtual_text,
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
      d.jump { count = count, severity = severity, float = true }
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
  local function lsp_lines()
    if first_time then
      first_time = false
      require("lsp_lines").toggle()
      require("lsp_lines").toggle()
    else
      require("lsp_lines").toggle()
    end
  end

  local dirop = X.dirop.wrap

  -- stylua: ignore
  local keys = {
    { "]d",  dirop(jump_dirop, 'next'),       desc = "[Diagnostic] Next issue"     },
    { "[d",  dirop(jump_dirop, 'prev'),       desc = "[Diagnostic] Previous issue" },
    { "]E",  dirop(jump_error_dirop, 'next'), desc = "[Diagnostic] Next error"     },
    { "[E",  dirop(jump_error_dirop, 'prev'), desc = "[Diagnostic] Previous error" },

    { "gl",  d.open_float,                    desc = "[Diagnostic] Show issue(s)"  },
    { "col", lsp_lines,                       desc = "[Lsp Lines] Toggle"          },

    { "yod", toggle,                          desc = "[Diagnostic] Toggle"         },

    { "gQ",  vim.diagnostic.setloclist,       desc = "[Diagnostic] Set loclist"    },
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
