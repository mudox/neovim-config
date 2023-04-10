local function init()
  -- vim.g.easy_align_ignore_groups = {'Comment', 'String'}

  vim.g.easy_align_bypass_fold = 1

  vim.g.easy_align_delimiters = {
    ["\\"] = {
      pattern = [[\\]],
    },
    d = {
      pattern = " \\ze\\S\\+\\s*[;=]",
      left_margin = 0,
      right_margin = 0,
    },
  }
end

local keys = {
  { "ga", "<Plug>(EasyAlign)", desc = "Easy Align" },
  { "<Enter>", "<Plug>(EasyAlign)", mode = "x", desc = "Easy Align" },
  { "ga", "<Plug>(EasyAlign)", mode = "x", desc = "Easy Align" },
}

return {
  "junegunn/vim-easy-align",
  dependencies = "vim-repeat",
  event = { "BufRead", "BufNewFile" },
  keys = keys,
  init = init,
}
