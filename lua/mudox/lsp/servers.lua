-- jsonls
vim.lsp.config("jsonls", {
  init_options = {
    provideFormatter = false,
  },
  settings = {
    json = {
      validate = { enable = true },
    },
  },
  before_init = function(_, config)
    config.settings.json.schemas = require("schemastore").json.schemas()
  end,
})

-- yamlls
vim.lsp.config("yamlls", {
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      customTags = { "!reference sequence" },
      format = { enable = false },
      schemaStore = {
        enable = false,
        url = "",
      },
    },
  },
  before_init = function(_, config)
    config.settings.yaml.schemas = require("schemastore").yaml.schemas()
  end,
})
