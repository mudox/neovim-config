url = 'scrooloose/nerdcommenter'

event = 'VimEnter'

function config()
  local g = vim.g

  g.NERDBlockComIgnoreEmpty = 1
  g.NERDSpaceDelims = 1
  g.NERDDefaultNesting = 0
end
