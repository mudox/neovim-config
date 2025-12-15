-- stylua: ignore
local formatters_by_ft = {
  lua             = { "stylua"                },

  python          = { "ruff"                  },

  rust            = { "rustfmt"               },

  json            = { "prettierd"             },
  jsonc           = { "prettierd"             },

  javascript      = { "biome"                 },
  javascriptreact = { "biome"                 },
  typescript      = { "biome"                 },
  typescriptreact = { "biome"                 },

  html            = { "prettierd", "injected" },
  css             = { "biome"                 },

  sh              = { "shfmt"                 },
  bash            = { "shfmt"                 },
  zsh             = { "shfmt"                 },

  -- for all filetypes
  ["*"]           = { "trim_whitespace"       },

  -- fallback
  ["_"]           = { "trim_whitespace"       },
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

  On.FileType(function()
    vim.wo.winhighlight = "NormalFloat:mdx_block_float,FloatBorder:mdx_block_float_border"
  end, { pattern = "conform-info" })

  -- conform.nvim
  X.swizzle_nvim_open_win:add_handler(function(ctx, orig, args)
    local r = vim.tbl_contains(ctx, function(v)
      return v.plugin == "conform.nvim"
    end, { predicate = true })
    if r then
      local tw = vim.o.columns
      local th = vim.o.lines
      local w = math.floor(tw * V.float.width)
      local h = math.floor(th * V.float.height)
      local x = math.floor((tw - w) / 2)
      local y = math.floor((th - h) / 2)

      args[3] = vim.tbl_deep_extend("force", args[3], {
        col = x,
        row = y,
        width = w,
        height = h,
      })
      return orig(unpack(args))
    else
      return false
    end
  end)

  setup_commands()
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
