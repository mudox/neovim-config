local opts = {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
      completion = {
        callSnippet = "Replace",
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
