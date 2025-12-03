local d = vim.diagnostic

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

local function setup_keymaps()
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

  -- nav
  K.nmap("[d", X.arrows.left(nav_issue), { desc = "issue" })
  K.nmap("]d", X.arrows.right(nav_issue), { desc = "issue" })
  K.nmap("[D", X.arrows.left(nav_error), { desc = "error" })
  K.nmap("]D", X.arrows.right(nav_error), { desc = "error" })

  -- view
  K.nmap("gl", d.open_float, { desc = "[diagnostic] show issue(s)" })
end

config()
setup_keymaps()
