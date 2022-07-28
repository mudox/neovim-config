-- Ref: https://github.com/microsoft/pyright/blob/main/docs/settings.md
-- Ref: https://github.com/microsoft/pyright/blob/main/docs/configuration.md

return {
  settings = {
    analysis = {
      python = {
        typeCheckingMode = "basic", -- [none, basic, strict]
      },
    },
  },
}
