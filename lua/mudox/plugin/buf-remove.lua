local function delete_buffer(force, close_win)
  return function()
    require("mini.bufremove").delete(0, force or false)
    if close_win then
      pcall(vim.cmd.wincmd, "c")
    end
  end
end

-- stylua: ignore start
local keys = {
  { "<C-w>r",     delete_buffer(false, false), desc = "Delete buffer",                },
  { "<C-w><C-r>", delete_buffer(false, true),  desc = "Delete buffer & close window", },
  { "<C-q>",      delete_buffer(false, true),  desc = "Delete buffer & close window", },
  { "<C-w>R",     delete_buffer(true, false),  desc = "Force delete buffer", },
}
-- stylua: ignore end

return {
  "echasnovski/mini.bufremove",
  event = { "BufRead", "BufNewFile" },
  config = function()
    require("mini.bufremove").setup()
  end,
  keys = keys,
}
