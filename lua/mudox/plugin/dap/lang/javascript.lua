-- https://theosteiner.de/debugging-javascript-frameworks-in-neovim
local function config()
  require("dap-vscode-js").setup {
    debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
    adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
  }
end

local debugger = {
  "microsoft/vscode-js-debug",
  opt = true,
  pin = true,
  build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
}

local adapter = {
  "mxsdev/nvim-dap-vscode-js",
  ft = { "javascript", "typescript" },
  dependencies = {
    "nvim-dap",
    debugger,
  },
  config = config,
}
-- https://theosteiner.de/debugging-javascript-frameworks-in-neovim#putting-it-all-together
local function setup()
  for _, lang in ipairs { "typescript", "javascript", "svelte" } do
    require("dap").configurations[lang] = {
      {
        name = "Attach debugger to existing `node --inspect` process",
        type = "pwa-node",
        request = "attach",

        processId = require("dap.utils").pick_process,
        sourceMaps = true,
        resolveSourceMapLocations = {
          "${workspaceFolder}/**",
          "!**/node_modules/**",
        },
        cwd = "${workspaceFolder}/src",
        skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
      },

      {
        name = "Launch Chrome to debug client",
        type = "pwa-chrome",
        request = "launch",

        -- default vite dev server url
        url = "http://localhost:5173",
        port = 9222,
        sourceMaps = true,
        protocol = "inspector",
        webRoot = "${workspaceFolder}/src",
        skipFiles = {
          "**/node_modules/**/*",
          "**/@vite/*",
          "**/src/client/*",
          "**/src/*",
        },
      },

      lang == "javascript" and {
        name = "Launch file in new node process",
        type = "pwa-node",
        request = "launch",

        program = "${file}",
        cwd = "${workspaceFolder}",
      } or nil,
    }
  end
end

return {
  adapter = adapter,
  setup = setup,
}
