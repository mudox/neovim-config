local opts = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      codeLens = {
        enable = true,
      },
      doc = {
        privateName = { "^_" },
      },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = "Disable",
        semicolon = "Disable",
        arrayIndex = "Disable",
      },
      workspace = {
        checkThirdParty = false,
      },
      completion = {
        callSnippet = "Replace",
      },
      telemetry = {
        enable = false,
      },
      semantic = {
        enable = false,
        annotation = false,
        keyword = false,
      },
    },
  },
}

return {
  opts = opts,
}
