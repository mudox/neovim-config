local function r(name)
  return require("mudox.plugin.git." .. name)
end

-- stylua: ignore
return {
  r"vscode-diff",
  r"fugitive",
  r"diffview",
  r"gitsigns",
  r"neogit",
  r"conflict",
}
