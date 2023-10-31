local function r(name)
  return require("mudox.plugin.telescope." .. name)
end

-- stylua: ignore
return {
  r "telescope",

  r "file-browser",
  r "heading",
  r "lazy",
  r "live-grep-args",
  r "luasnip",
  r "smart-open",
  r "symbols",
}
