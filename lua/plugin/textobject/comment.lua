url = 'glts/vim-textobj-comment'

event = 'VimEnter'

function config()
  vim.g.textobj_comment_no_default_key_mappings = 1
  -- " xmap ax <Plug>(textobj-comment-a)
  -- " omap ax <Plug>(textobj-comment-a)
  -- " xmap ix <Plug>(textobj-comment-i)
  -- " omap ix <Plug>(textobj-comment-i)
  -- " xmap aX <Plug>(textobj-comment-big-a)
  -- " omap aX <Plug>(textobj-comment-big-a)
end
