local providers_per_ft = {
  ["_"] = { "treesitter", "indent" },
  lua = { "treesitter", "lsp" },
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

  On({ "CursorHold", "CursorHoldI", "WinEnter" }, function()
    local backlist = { "Navbuddy", "snacks_dashboard" }
    if vim.tbl_contains(backlist, vim.bo.filetype) then
      return
    end

    if vim.wo.foldlevel ~= 99 then
      print(("[ufo] foldlevel (%d) != 99, restore"):format(vim.wo.foldlevel))
      vim.wo.foldlevel = 99
    end
  end)
end

local ufo = { level = 0 }

function ufo:notify()
  print("fold level " .. self.level)
end

function ufo:zM()
  self.level = 0
  require("ufo").closeAllFolds()
  ufo:notify()
end

function ufo:zm()
  self.level = math.max(0, self.level - 1)
  require("ufo").closeFoldsWith(self.level)
  ufo:notify()
end

function ufo:zR()
  self.level = 8 -- HACK: magic number
  require("ufo").openAllFolds()
  ufo:notify()
end

function ufo:zr()
  self.level = math.min(99, self.level + 1)
  require("ufo").closeFoldsWith(self.level)
  ufo:notify()
end

-- stylua: ignore
local fold = {
  name  = "fold Level",
  left  = function() ufo:zm() end,
  right = function() ufo:zr() end,
  up    = function() ufo:zM() end,
  down  = function() ufo:zR() end,
  notify = function() end
}

-- stylua: ignore
local keys = {
  { "zR",    X.arrows.down(fold),  desc = "[ufo] open all",  },
  { "zM",    X.arrows.up(fold),    desc = "[ufo] close all", },

  { "zr",    X.arrows.right(fold), desc = "[ufo] open +",    },
  { "zm",    X.arrows.left(fold),  desc = "[ufo] close -",   },

  { "zx",    "zMzv", remap = true, desc = "[ufo] zx",        },
  { K.p"vu", K.c"UfoInspect",      desc = "ufo",             },
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
