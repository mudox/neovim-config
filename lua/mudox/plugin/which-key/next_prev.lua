local dirop = X.dirop.wrap

local function cmd_dirop(name, next, prev)
  return {
    name = name,
    next = function()
      vim.cmd("silent! " .. next)
    end,
    prev = function()
      vim.cmd("silent! " .. prev)
    end,
  }
end

local insert_blankline = {
  name = "insert blankline",
  next = function()
    vim.cmd("put  =repeat(nr2char(10), v:count1)|silent '[-")
  end,
  prev = function()
    vim.cmd("put! =repeat(nr2char(10), v:count1)|silent ']+")
  end,
}

local swap_line = {
  name = "swap line",
  next = function()
    vim.cmd("silent! move +" .. vim.v.count1)
    vim.cmd.normal("==")
  end,
  prev = function()
    vim.cmd("silent! move --" .. vim.v.count1)
    vim.cmd.normal("==")
  end,
}

local change_point = {
  name = "change point",
  next = function()
    vim.cmd.normal { "g,", bang = true }
  end,
  prev = function()
    vim.cmd.normal { "g;", bang = true }
  end,
}

-- stylua: ignore start
local afile    = cmd_dirop("argument file", "next",    "previous")
local quickfix = cmd_dirop("quickfix item", "cnext",   "cprevious")
local qfile    = cmd_dirop("quickfix file", "cnfile",  "cpfile")
local loclist  = cmd_dirop("loclist",       "lnext",   "lprevious")
local lfile    = cmd_dirop("loclist file",  "lnfile",  "lpfile")
local tabpage  = cmd_dirop("tabpage",       "tabnext", "tabprevious")
-- stylua: ignore end

-- stylua: ignore
local next = {
  name = "+next",

  [";"]       = { dirop(change_point,     "next"), "Next change point"  },

  a           = { dirop(afile,            "next"), "Next argument file" },
  q           = { dirop(quickfix,         "next"), "Next quickfix item" },
  Q           = { dirop(qfile,            "next"), "Next quickfix file" },
  l           = { dirop(loclist,          "next"), "Next loclist item"  },
  L           = { dirop(lfile,            "next"), "Next loclist file"  },
  ["<Tab>"]   = { dirop(tabpage,          "next"), "Next tabpage"       },

  e           = { dirop(swap_line,        "next"), "Swap line down"     },
  ["<Space>"] = { dirop(insert_blankline, "next"), "Add line(s) below"  },
}

-- stylua: ignore
local prev = {
  name = "+previous",

  [";"]       = { dirop(change_point,     "prev"), "Previous change point"  },

  a           = { dirop(afile,            "prev"), "Previous argument file" },
  q           = { dirop(quickfix,         "prev"), "Previous quickfix item" },
  Q           = { dirop(qfile,            "prev"), "Previous quickfix file" },
  l           = { dirop(loclist,          "prev"), "Previous loclist item"  },
  L           = { dirop(lfile,            "prev"), "Previous loclist file"  },
  ["<Tab>"]   = { dirop(tabpage,          "prev"), "Previous tabpage"       },

  e           = { dirop(swap_line,        "prev"), "Swap line up"           },
  ["<Space>"] = { dirop(insert_blankline, "prev"), "Add line(s) above"      },
}

return {
  next = next,
  prev = prev,
}
