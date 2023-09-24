return {
  name = "run script",

  builder = function()
    local file = vim.fn.expand("%:p")
    local cmd = { file }

    if vim.bo.filetype == "sh" then
      cmd = { "sh", file }
    elseif vim.bo.filetype == "zsh" then
      cmd = { "zsh", file }
    elseif vim.bo.filetype == "python" then
      cmd = { "python", file }
    elseif vim.bo.filetype == "lua" then
      cmd = { "lua", file }
    elseif vim.bo.filetype == "go" then
      cmd = { "go", "run", file }
    end

    return {
      name = "run " .. vim.fn.expand("%"),
      cmd = cmd,
      components = {
        { "on_output_quickfix", set_diagnostics = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end,

  condition = {
    filetype = { "sh", "zsh", "python", "go", "lua" },
  },
}
