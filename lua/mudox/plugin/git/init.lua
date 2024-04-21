local function r(name)
  return require("mudox.plugin.git." .. name)
end

-- stylua: ignore
return {
  r "fugitive",
  r "diffview",
  r "gitsigns",
  r "neogit",
  r "conflict",
}
