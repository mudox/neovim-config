local d = vim.diagnostic

local function toggle_virtual_lines()
  local flag = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config { virtual_lines = flag }
end

local function config()
  local sign = I.diagnostic.sign
  local signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = sign,
      [vim.diagnostic.severity.WARN] = sign,
      [vim.diagnostic.severity.INFO] = sign,
      [vim.diagnostic.severity.HINT] = sign,
    },
  }

  local float = {
    source = true,
    prefix = sign .. " ",
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

  local nav_issue = {
    name = "Diagnostic issue",
    left = jump(false),
    right = jump(true),
  }

  local nav_error = {
    name = "Diagnostic error",
    left = jump(false, "ERROR"),
    right = jump(true, "ERROR"),
  }

  local function toggle()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    local enabled = d.is_enabled() and "enabled" or "disabled"
    vim.notify("Diagnostic is " .. enabled, vim.log.levels.INFO, { title = "LSP" })
  end

  local first_time = true

  K.nnop("[D")
  K.nnop("]D")
  -- stylua: ignore
  local keys = {
    -- nav
    { "[d",  X.arrows.left(nav_issue),  desc = "issue" },
    { "]d",  X.arrows.right(nav_issue), desc = "issue" },
    { "[E",  X.arrows.left(nav_error),  desc = "error" },
    { "]E",  X.arrows.right(nav_error), desc = "error" },

    -- view
    { "gl",  d.open_float,                    desc = "[diagnostic] show issue(s)"  },

    -- toggle
    -- see snacks/toggle.lua
  }

  require("which-key").add(keys, { buffer = bufnr })
end

local function setup()
  config()
  -- setup_signs()

  On.LspAttach(setup_keymaps)
end

return {
  setup = setup,
}
