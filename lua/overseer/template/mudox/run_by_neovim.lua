---@type overseer.TemplateFileDefinition
return {
  name = "run by neovim",

  condition = {
    filetype = "lua",
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
