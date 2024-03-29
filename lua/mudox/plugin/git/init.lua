local function r(name)
  return require("mudox.plugin.git." .. name)
end

-- stylua: ignore
return {
  r "fugitive",
  r "diff-view",
  r "git-signs",
  r "neogit",
  r "conflict",
}
