local opts = {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
      completion = {
        callSnippet = "Replace",
      },
      telemetry = {
        enable = false,
      },
      hint = {
        enable = true,
      },
    },
  },
}

return {
  opts = opts,
}
