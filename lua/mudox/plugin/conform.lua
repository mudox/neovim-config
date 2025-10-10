-- stylua: ignore
local formatters_by_ft = {
  lua             = { "stylua"          },

  python          = { "ruff"            },

  rust            = { "rustfmt"         },

  json            = { "biome"           },

  javascript      = { "biome"           },
  javascriptreact = { "biome"           },
  typescript      = { "biome"           },
  typescriptreact = { "biome"           },

  html            = { "biome", "injected" },
  css             = { "biome"           },

  sh              = { "shfmt"           },
  bash            = { "shfmt"           },
  zsh             = { "shfmt"           },

  -- for all filetypes
  ["*"]           = { "trim_whitespace" },

  -- fallback
  ["_"]           = { "trim_whitespace" },
}

local slow_fts = {
  sql = true,
  java = true,
}

-- for
-- - fast formatters
-- - formatter that support stdin
local format_on_save = function(bufnr)
  -- check toggle
  if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
    return
  end

  -- filter by filetype
  if slow_fts[vim.bo[bufnr].filetype] then
    return
  end

  -- filter by path
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if bufname:match("/node_modules/") then
    return
  end

  return { timeout_ms = 500, lsp_fallback = true }
end

-- for
-- - slow formatters
-- - formatter that does not support stdin
local format_after_save = function(bufnr)
  -- filter by filetype
  if not slow_fts[vim.bo[bufnr].filetype] then
    return
  end

  return { lsp_fallback = true }
end

local function setup_commands()
  vim.api.nvim_create_user_command("Conformat", function(args)
    local range = nil
    if args.count ~= -1 then
      local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
      range = {
        ["start"] = { args.line1, 0 },
        ["end"] = { args.line2, end_line:len() },
      }
    end
    require("conform").format { async = true, lsp_fallback = true, range = range }
  end, { range = true })

  vim.api.nvim_create_user_command("FOSDisable", function(args)
    if args.bang then
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
  end, {
    desc = "Disable autoformat-on-save",
    bang = true,
  })

  vim.api.nvim_create_user_command("FOSEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
  end, {
    desc = "Re-enable autoformat-on-save",
  })
end

local function config()
  require("conform").setup {
    formatters_by_ft = formatters_by_ft,
    format_on_save = format_on_save,
    format_after_save = format_after_save,
  }

  setup_commands()
end

local function toggle(global)
  return function()
    local s = global and "g" or "b"
    vim[s].disable_autoformat = not vim[s].disable_autoformat

    local msg = ([[Autoformat turned %s %s]]):format(
      vim[s].disable_autoformat and "OFF" or "ON",
      global and "globally" or "for current buffer"
    )
    vim.notify(msg, vim.log.levels.INFO, { title = "Conform" })
  end
end

-- stylua: ignore
local keys = {
  { "<Bslash>q",  "<Cmd>Conformat<Cr>", mode = { "n", "v" }, desc = "[Conform] Format" },
  { K.p"vq", "<Cmd>ConformInfo<Cr>",                    desc = "Conform" },
}

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = { "Conformat", "ConformInfo" },
  keys = keys,
  config = config,
}
