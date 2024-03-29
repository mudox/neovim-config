return {
  name = "run neovim lua script",

  condition = {
    filetype = { "lua" },
  },

  builder = function()
    local file = vim.fn.expand("%:p")
    local cmd = { "nvim", "-l", file }

    return {
      cmd = cmd,
      components = {
        { "on_output_quickfix", set_diagnostics = true },
        "on_result_diagnostics",
        "default",
      },
    }
  end,
}
