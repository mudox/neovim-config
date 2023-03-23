local function config()
  local dev_icons = require("nvim-web-devicons")
  dev_icons.setup {}

  local i = require("mudox.ui").icons.filetype
  local icons = dev_icons.get_icons()

  -- NOTE: do not put spaces in `name` field
  -- It is used for `hi` command as group name

  icons[".gitattributes"].icon = i.git
  icons[".gitignore"].icon = i.git

  icons["md"].icon = i.markdown
  icons["md"].color = "#ffffff"

  icons["toml"].icon = i.config
  icons["toml"].color = "#9c4221"

  icons["yml"].icon = i.config
  icons["yml"].color = "#cb171d"

  icons["java"].icon = i.java
  icons["java"].color = "#d60200"

  icons["class"] = {
    name = "JavaCompiledFile",
    icon = i.compiled,
    color = "#666666",
  }

  icons.norg = {
    name = "Neorg",
    icon = i.neorg,
    color = "#18b63a",
  }

  icons.bak = {
    name = "BackupFile",
    icon = i.backup,
    color = "#666666",
  }

  icons["zsh"].icon = i.script

  icons["m"] = {
    name = "ObjectiveCSourceFile",
    icon = i.apple,
    color = "#d17cff",
  }

  for k, v in pairs(icons) do
    local icon = v.icon
    icon = icon:gsub("^%s+", "") -- trim prefixing spaces
    icon = icon:gsub("%s+$", "") -- trim trailing spaces
    icons[k].icon = icon
  end

  dev_icons.set_icon(icons)
end

return {
  "kyazdani42/nvim-web-devicons",
  config = config,
}
