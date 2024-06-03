return {
  name = "quick run",

  condition = {
    filetype = { "sh", "zsh", "python", "go", "nu" },
  },

  builder = function()
    local file = vim.fn.expand("%:p")
    local cmd = { file }

    local ft = vim.bo.filetype
    -- stylua: ignore
    if     ft == "sh"     then cmd = { "sh",        file }
    elseif ft == "bash"   then cmd = { "bash",      file }
    elseif ft == "zsh"    then cmd = { "zsh",       file }
    elseif ft == "python" then cmd = { "python",    file }
    elseif ft == "go"     then cmd = { "go", "run", file }
    elseif ft == "nu"     then cmd = { "nu",        file }
    end

    return {
      name = "quick run " .. vim.fn.expand("%:t"),
      cmd = cmd,
      components = {
        "on_result_diagnostics",
        "default",
      },
    }
  end,
}
