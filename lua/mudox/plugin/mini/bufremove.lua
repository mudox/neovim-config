local function delete_buffer(force, close_win)
  return function()
    require("mini.bufremove").delete(0, force or false)
    if close_win then
      pcall(vim.cmd.wincmd, "c")
    end
  end
end

-- stylua: ignore
local keys = {
  { "<Bs>b", delete_buffer(false, false), desc = "[bufremove] delete",                      },
  { "<Bs>B", delete_buffer(true,  false), desc = "[bufremove] force delete",                },

  { "<Bs>x", delete_buffer(false, true),  desc = "[bufremove] delete & close window",       },
  { "<Bs>X", delete_buffer(true,  true),  desc = "[bufremove] force delete & close window", },
}

return {
  setup = function()
    require("mini.bufremove").setup {}
  end,
  keys = keys,
}
