url = "rcarriga/vim-ultest"

requires = { "vim-test/vim-test" }

run = ":UpdateRemotePlugins"

-- LATER: use more specific conditions
event = "BufRead"

after = "vim-test"
