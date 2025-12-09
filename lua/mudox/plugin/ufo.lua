local providers_per_ft = {
  ["_"] = { "lsp", "indent" },
}

local handler = function(virt_text, lnum, end_lnum, width, truncate)
  local new_virt_text = {}
  local suffix = { "  ", "Folded" }
  local suf_width = vim.fn.strdisplaywidth(suffix[1])
  local target_width = width - suf_width
  local cur_width = 0

  for _, chunk in ipairs(virt_text) do
    local chunk_text = chunk[1]
    local chunk_width = vim.fn.strdisplaywidth(chunk_text)
    if target_width > cur_width + chunk_width then
      table.insert(new_virt_text, chunk)
    else
      chunk_text = truncate(chunk_text, target_width - cur_width)
      local hlGroup = chunk[2]
      table.insert(new_virt_text, { chunk_text, hlGroup })
      chunk_width = vim.fn.strdisplaywidth(chunk_text)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if cur_width + chunk_width < target_width then
        suffix = suffix .. (" "):rep(target_width - cur_width - chunk_width)
      end
      break
    end
    cur_width = cur_width + chunk_width
  end

  table.insert(new_virt_text, suffix)
  return new_virt_text
end

local opts = {
  close_fold_kinds = {},
  -- open_fold_hl_timeout = 0, -- disable
  ---@diagnostic disable-next-line: unused-local
  provider_selector = function(bufnr, filetype, buftype)
    return providers_per_ft[filetype] or providers_per_ft["_"]
  end,
  fold_virt_text_handler = handler,
  preview = {
    win_config = {
      border = { "", "─", "", "", "", "─", "", "" },
      winhighlight = "Normal:NormalFloat",
      winblend = 0,
      title = "fold preview",
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

local function preview()
  require("ufo").peekFoldedLinesUnderCursor()
end

-- stylua: ignore
local keys = {
  { "zR",    function() require("ufo").openAllFolds() end,               desc = "[ufo] open all folds",  },
  { "zM",    function() require("ufo").closeAllFolds() end,              desc = "[ufo] close all folds", },

  { "zr",    function() require("ufo").openFoldsExceptKinds() end,       desc = "[ufo] open fold",       },
  { "zm",    function() require("ufo").closeFoldsWith() end,             desc = "[ufo] close fold",      },

  { "zx",    "zMzv", remap = true,                                       desc = "[ufo] close all folds", },

  { "gj",    function() require('ufo').peekFoldedLinesUnderCursor() end, desc = "[ufo] preview",         },

  { K.p"vu", K.c"UfoInspect",                                            desc = "ufo",                   },
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
