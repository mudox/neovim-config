-- stylua: ignore
local function r(name) return require("mudox.plugin.telescope." .. name) end

-- stylua: ignore
return {
  r "telescope",
  r "ctags",
  r "file-browser",
  -- r "frecency",
  -- r "heading",
  r "help-grep",
  r "lazy",
  -- r "live-grep-args",
  r "luasnip",
  r "smart-open",
  -- r "symbols",
}
