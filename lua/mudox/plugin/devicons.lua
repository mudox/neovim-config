local function opts()
  local i = require("mudox.ui.icon").filetype

  -- NOTE: do not put spaces in `name` field
  -- It is used for `hi` command as group name

  local ret = {}

  ret.override_by_filename = {
    [".gitattributes"] = { icon = i.git },
    [".gitignore"] = { icon = i.git },
  }

  ret.override = {
    md = {
      icon = i.markdown,
      color = "#ffffff",
    },
    java = {
      icon = i.java,
      color = "#d60200",
    },
    class = {
      name = "JavaCompiledFile",
      icon = i.compiled,
      color = "#666666",
    },
    norg = {
      name = "Neorg",
      icon = i.neorg,
      color = "#18b63a",
    },
    bak = {
      name = "BackupFile",
      icon = i.backup,
      color = "#666666",
    },
    m = {
      name = "ObjectiveCSourceFile",
      icon = i.apple,
      color = "#d17cff",
    },
  }

  return ret
end

return {
  "kyazdani42/nvim-web-devicons",
  opts = opts,
}
