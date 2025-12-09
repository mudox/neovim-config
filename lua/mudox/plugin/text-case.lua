return {
  "johmsalas/text-case.nvim",
  keys = {
    { "\\c", K.c("TextCaseOpenTelescope"), mode = { "n", "x" }, desc = "text case" },
  },
  cmd = {
    "Subs",
    "TextCaseOpenTelescope",
    "TextCaseOpenTelescopeQuickChange",
    "TextCaseOpenTelescopeLSPChange",
    "TextCaseStartReplacingCommand",
  },
  opts = {},
}
