-- stylua: ignore start
local keys = {
  -- normal mode
  { "b", function() require("refactoring").refactor("Extract Block") end, desc = "Extract Block", },
  { "B", function() require("refactoring").refactor("Extract Block To File") end, desc = "Extract Block To File", },
  { "i", function() require("refactoring").refactor("Inline Variable") end, desc = "Inline Variable", },
  { "p", function() require("refactoring").debug.printf { below = false } end, desc = "Print function call", },
  { "c", function() require("refactoring").debug.cleanup {} end, desc = "Cleanup debug prints", },
  -- visual mode
  { "r", function() require("refactoring").select_refactor() end, desc = "Refactor selection", },
  { "p", function() require("refactoring").debug.print_var {} end, desc = "Print variable", },
}
-- stylua: ignore end

for _, k in ipairs(keys) do
  k[1] = "\\" .. k[1]
end

return {
  "ThePrimeagen/refactoring.nvim",
  event = { "BufRead", "BufNewFile" },
  opts = true,
  keys = keys,
}
