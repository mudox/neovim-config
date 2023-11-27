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
  { "<leader>bb", delete_buffer(false, false), desc = "[Buf Remove] Delete",                },
  { "<leader>bx", delete_buffer(true,  false), desc = "[Buf Remove] Force delete",          },
  { "<leader>bw", delete_buffer(false, true),  desc = "[Buf Remove] Delete & close window", },
}

return {
  "echasnovski/mini.bufremove",
  event = { "BufRead", "BufNewFile" },
  config = function()
    require("mini.bufremove").setup()
  end,
  keys = keys,
}
