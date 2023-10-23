local function r(name)
  return require("mudox.plugin.git." .. name)
end

-- stylua: ignore
return {
  r "diff-view",
  r "fugitive",
  r "conflict",
  r "signs",
  r "neogit",
}
