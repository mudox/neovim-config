-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#vscode-js-debug
-- Options for vscode-js-debug https://github.com/microsoft/vscode-js-debug/blob/main/OPTIONS.md

local function setup()
  require("dap").adapters["pwa-node"] = {
    type = "server",
    host = "127.0.0.1",
    port = "${port}",
    executable = {
      command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
      args = { "${port}" },
    },
  }

  for _, lang in ipairs { "typescript", "javascript" } do
    require("dap").configurations[lang] = {
      {
        name = "Launch file in new node process",
        type = "pwa-node",
        request = "launch",

        program = "${file}",
        cwd = "${workspaceFolder}",

        sourceMaps = true,
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
    }
  end
end

return {
  setup = setup,
}
