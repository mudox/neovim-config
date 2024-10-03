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
  { "<Bs>b",      delete_buffer(false, false), desc = "[BufRemove] Delete",                },
  { "<Bs>B",      delete_buffer(true,  false), desc = "[BufRemove] Force delete",          },

  { "<Bs>x",      delete_buffer(false, true),  desc = "[BufRemove] Delete & close window", },
  { "<Bs>X",      delete_buffer(true, true),   desc = "[BufRemove] Force delete & close window", },
}

return {
  "echasnovski/mini.bufremove",
  event = { "BufRead", "BufNewFile" },
  config = function()
    require("mini.bufremove").setup()
  end,
  keys = keys,
}
