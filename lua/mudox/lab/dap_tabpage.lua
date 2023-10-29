local function open_dap_tabpage()
  local varname = "mdx_is_dap_tabpage"

  -- create new one
  vim.cmd.tabnew()
  vim.api.nvim_tabpage_set_var(0, varname, true)
  local id = vim.api.nvim_get_current_tabpage()

  -- close all old dap tabpages if any
  for _, v in ipairs(vim.api.nvim_list_tabpages()) do
    if v ~= id and pcall(vim.api.nvim_tabpage_get_var, v, varname) then
      vim.api.nvim_set_current_tabpage(v)
      vim.cmd.tabclose()
    end
  end

  return vim.api.nvim_get_current_tabpage()
end

open_dap_tabpage()
require("dapui").open()
