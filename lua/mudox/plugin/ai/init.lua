-- stylua: ignore
local function r(name) return require("mudox.plugin.ai." .. name) end

-- stylua: ignore
return {
  r"chatgpt",
  r"codeium",
  r"codecompanion",
  r"supermaven",
}