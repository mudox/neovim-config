local formatters_by_ft = {
  -- Conform will run multiple formatters sequentially
  -- Use a sub-list to run only the first available formatter
  lua = { "stylua" },
  python = { "isort", "black" },
  javascript = { "prettierd" },

  -- Use the "*" filetype to run formatters on all filetypes.
  ["*"] = { "codespell", "trim_whitespace" },
  -- Use the "_" filetype to run formatters on filetypes that don't
  -- have other formatters configured.
  ["_"] = { "trim_whitespace" },
}

local fast_fts = {
  lua = true,
  rust = true,
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
  if not fast_fts[vim.bo[bufnr].filetype] then
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

local function format_command()
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
end

local function config()
  require("conform").setup {
    formatters_by_ft = formatters_by_ft,
    format_on_save = format_on_save,
    format_after_save = format_after_save,
  }

  format_command()
end

local keys = {
  { "\\q", "<Cmd>Conformat<Cr>", mode = { "n", "v" }, desc = "[Conform] Format" },
  { "<leader>vc", "<Cmd>ConformInfo<Cr>", desc = "Conform" },
}

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = keys,
  opts = opts,
  config = config,
}
