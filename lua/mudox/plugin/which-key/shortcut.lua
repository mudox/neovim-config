local k = K.sc

local function open_alternative()
  if vim.fn.bufname("#") ~= "" then
    X.layout.secondary:open("#")
  else
    X.layout.secondary:open()
  end
end

local function open_or_alternate()
  if vim.api.nvim_get_current_win() ~= X.layout.secondary:winid() then
    -- not in secondary win, open it
    X.layout.secondary:open()
  else
    -- in secondary win, alternate if any
    if vim.fn.bufname("#") ~= "" then
      vim.cmd.edit("#")
    else
      print("no # file")
    end
  end
end

-- stylua: ignore
return {
  { k"1",       function() X.layout.main:focus() end,     desc = "main window"      },
  { "<C-Cr>",   function() X.layout.main:focus() end,     desc = "main window"      },
  { k"2",       function() X.layout.secondary:open() end, desc = "secondary window" },
  { k"3",       function() X.layout.one_window() end,     desc = "main window only" },

  { k"v",       open_alternative, desc = "edit #" },
  { "<C-S-CR>", open_or_alternate, desc = "open or edit #" },

  { k"m",       "g<",             desc = "g<"        },
  { k"M",       K.c"message",     desc = ":messages" },
}
