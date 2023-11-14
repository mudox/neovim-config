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
