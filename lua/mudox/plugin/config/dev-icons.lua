local dev_icons = require("nvim-web-devicons")
dev_icons.setup {}

local icons = dev_icons.get_icons()

-- NOTE: do not put spaces in `name` field
-- It is used for `hi` command as group name

-- stylua: ignore start
icons[".gitattributes"].icon = " "
icons[".gitignore"].icon     = " "
-- icons[".gitignore"].color    = "#e94e31"

icons["md"].icon             = " "
icons["md"].color            = "#fff"

icons["toml"].icon           = " "
icons["toml"].color          = "#9c4221"

icons["yml"].icon            = " "
icons["yml"].color           = "#cb171d"

icons["java"].icon           = " "
icons["java"].color          = "#d60200"

icons["class"]               = {
  name                       = "JavaCompiledFile",
  icon                       = " ",
  color                      = "#666",
}

icons.norg                   = {
  name                       = "Neorg",
  icon                       = " ",
  color                      = "#18b63a",
}

icons.bak                    = {
  name                       = "BackupFile",
  icon                       = " ",
  color                      = "#666",
}

icons["zsh"].icon         = " "
-- stylua: ignore end

for k, v in pairs(icons) do
  local icon = v.icon
  icon = icon:gsub("^%s+", "") -- trim prefixing spaces
  icon = icon:gsub("%s+$", "") -- trim trailing spaces
  icons[k].icon = icon
end

dev_icons.set_icon(icons)
