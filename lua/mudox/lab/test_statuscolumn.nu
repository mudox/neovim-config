def main [] {
  let f1 = $env.MDX_NVIM_DIR + '/lua/mudox/plugin/git/gitsigns.lua'
  let cmd = 'autocmd CursorHold * ++once set statuscolumn=%!v:lua.X.statuscolumn()'
  tmux respawn-pane -k -t '{right-of}' nvim -c $cmd $f1
}
