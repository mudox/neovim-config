local function r(name)
  return require("mudox.plugin.treesitter." .. name)
end

-- stylua: ignore
return {
  r"treesitter",
  r"context-comment-string",
  r"textobjects",
}
