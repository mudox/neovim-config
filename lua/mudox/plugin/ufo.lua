local ft_providers_map = {
  git = "",
  lua = "treesitter",
  python = "treesitter",
  vim = "treesitter",
}

local function fallback_selector(bufnr)
  local function handle_fallback_exception(err, provider_name)
    if type(err) == "string" and err:match("UfoFallbackException") then
      return require("ufo").getFolds(bufnr, provider_name)
    else
      return require("promise").reject(err)
    end
  end

  return require("ufo")
    .getFolds(bufnr, "lsp")
    :catch(function(err)
      return handle_fallback_exception(err, "treesitter")
    end)
    :catch(function(err)
      return handle_fallback_exception(err, "indent")
    end)
end

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local totalLines = vim.api.nvim_buf_line_count(0)
  local foldedLines = endLnum - lnum
  local suffix = ("  %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
  suffix = (" "):rep(rAlignAppndx) .. suffix
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

local function setup_lsp_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  local servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
  for _, ls in ipairs(servers) do
    require("lspconfig")[ls].setup {
      capabilities = capabilities,
    }
  end
end

local opts = {
  open_fold_hl_timeout = 0, -- disable
  ---@diagnostic disable-next-line: unused-local
  provider_selector = function(bufnr, filetype, buftype)
    return ft_providers_map[filetype] or fallback_selector
  end,
  fold_virt_text_handler = handler,
  close_fold_kinds = { "imports", "comment" },
  preview = {
    win_config = {
      border = { "", "─", "", "", "", "─", "", "" },
      -- winhighlight = "Normal:Folded",
      winblend = 0,
    },
    mappings = {
      scrollU = "<C-u>",
      scrollD = "<C-d>",
      jumpTop = "[",
      jumpBot = "]",
    },
  },
}

local function config()
  vim.o.foldenable = true
  vim.o.foldcolumn = "1" -- '0' is not bad
  vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  vim.o.foldlevelstart = 99
  vim.o.foldminlines = 6

  setup_lsp_capabilities()

  require("ufo").setup(opts)
end

-- stylua: ignore
local keys = {
  { "zR", function() require("ufo").openAllFolds() end, desc = "[UFO] Open all folds", },
  { "zM", function() require("ufo").closeAllFolds() end, desc = "[UFO] Close all folds", },
  { "zx", "zMzv", remap = true, desc = "[UFO] Close all folds", },
  -- vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
  -- vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
}

return {
  "kevinhwang91/nvim-ufo",
  event = { "BufRead", "BufNewFile" },
  keys = keys,
  dependencies = {
    "kevinhwang91/promise-async",
    "statuscol.nvim",
  },
  config = config,
  cond = false,
}
