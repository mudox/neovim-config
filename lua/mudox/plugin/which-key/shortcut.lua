local k = K.sc

local function open_alternative()
  if vim.fn.bufname("#") ~= "" then
    X.layout.secondary:open("#")
  else
    X.layout.secondary:open()
  end
end

-- stylua: ignore
return {
  { k"1",       function() X.layout.main:focus() end,     desc = "main window"      },
  { "<C-Cr>",   function() X.layout.main:focus() end,     desc = "main window"      },
  { k"2",       function() X.layout.secondary:open() end, desc = "secondary window" },
  { k"3",       function() X.layout.one_window() end,     desc = "main window only" },

  { k"v",       open_alternative, desc = "edit #" },
  { "<C-S-Cr>", open_alternative, desc = "edit #" },

  { k"m",       "g<",             desc = "messages" },
}
