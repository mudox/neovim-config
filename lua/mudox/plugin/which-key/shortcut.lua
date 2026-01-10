local k = K.sc

local function quick_test()
  local n
  if vim.v.count1 ~= 1 then
    n = vim.v.count1
  elseif V.t then
    n = V.t
  else
    n = 1
  end
  local f = ".mise/tasks/t" .. n
  if vim.uv.fs_stat(f) then
    print("run task file " .. f)
    vim.system { f }
  else
    print(("task file %s does not exist"):format(f))
  end
end

-- stylua: ignore
return {
  { k"1", function() X.layout.left:focus() end,     desc = "main window"            },
  { k"2", function() X.layout.right:open() end,     desc = "secondary window"       },
  { k"3", function() X.layout.one_window() end,     desc = "main window only"       },

  { k"v", function() X.layout.right:open_alt() end, desc = "right #"                },

  { k"m", "g<",                                     desc = "g<"                     },
  { k"M", K.c"message",                             desc = ":messages"              },

  { k"t", quick_test,                               desc = "quick test"             },

  { k"G", function() Snacks.picker.grep() end,      desc = "[snacks] grep"          },
  { k"g", K.c"Telescope live_grep",                 desc = "[telescope] live grep", },

  { k"/", K.c"Telescope help_tags",                 desc = "[telescope] vim help",  },
}
