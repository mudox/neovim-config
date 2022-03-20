local dev_icons = require("nvim-web-devicons")
dev_icons.setup {}

local icons = dev_icons.get_icons()

-- stylua: ignore start
icons[".gitignore"].icon  = " "
icons[".gitignore"].color = "#e94e31"

icons["md"].icon          = " "
icons["md"].color         = "#fff"

icons["toml"].icon        = " "
icons["toml"].color       = "#9c4221"

icons["yml"].icon         = " "
icons["yml"].color        = "#cb171d"

icons["zsh"].icon         = " "
-- stylua: ignore end

for k, v in pairs(icons) do
  local icon = v.icon
  icon = icon:gsub("^%s*", "") -- trim prefixing spaces
  icon = icon:gsub("%s+$", "") -- trim trailing spaces
  icons[k].icon = icon
end

dev_icons.set_icon(icons)
