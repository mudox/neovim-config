url = 'scrooloose/nerdcommenter'

keys = {{'n', ',c<Space>'}, {'v', ',c<Space>'}}

function config()
  local g = vim.g

  g.NERDBlockComIgnoreEmpty = 1
  g.NERDSpaceDelims = 1
  g.NERDDefaultNesting = 0
end
