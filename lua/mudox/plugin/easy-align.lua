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

-- stylua: ignore
local keys = {
  { "g<Enter>", "gv<Plug>(EasyAlign)", desc = "[EasyAlign] Align on last visual area" },
  { "<Enter>", "<Plug>(EasyAlign)",    desc = "[EasyAlign] Align", mode = "x"         },
}

return {
  "junegunn/vim-easy-align",
  dependencies = "vim-repeat",
  keys = keys,
  init = init,
}
