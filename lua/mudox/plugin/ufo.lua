local providers_per_ft = {
  -- lua = { "treesitter", "indent" },
  -- python = { "treesitter", "indent" },
  -- vim = { "treesitter", "indent" },
  html = { "treesitter", "indent" },

  ["_"] = { "lsp", "indent" },
}

local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = { "  ", "Folded" }
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

  table.insert(newVirtText, suffix)
  return newVirtText
end

local opts = {
  close_fold_kinds = {},
  -- open_fold_hl_timeout = 0, -- disable
  ---@diagnostic disable-next-line: unused-local
  -- provider_selector = function(bufnr, filetype, buftype)
  --   return providers_per_ft[filetype] or providers_per_ft["_"]
  -- end,
  fold_virt_text_handler = handler,
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
  vim.o.foldcolumn = "0" -- hide
  vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  vim.o.foldlevelstart = 99

  require("ufo").setup(opts)
end

-- stylua: ignore
local keys = {
  { "zR", function() require("ufo").openAllFolds() end,         desc = "[ufo] open all folds",  },
  { "zM", function() require("ufo").closeAllFolds() end,        desc = "[ufo] close all folds", },

  { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "[ufo] open fold",       },
  { "zm", function() require("ufo").closeFoldsWith() end,       desc = "[ufo] close fold",      },

  { "zx", "zMzv", remap = true, desc = "[ufo] close all folds", },
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
  cond = V.ufo,
}
