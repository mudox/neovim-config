#!/usr/bin/env nu

# nvim appname manager

let basedir = '~/.config' | path expand

def 'main list' [] {
  ls --short-names $basedir
  | where name =~ '^nvim-'
  | each { $in.name | str substring 5.. }
}

def 'main new' [name: string] {
  mkdir $'($basedir)/nvim-($name)'
  print 'appnames'
  print '--------'
  main list | to text
}

def 'main run' [name: string] {
  let name = $name | default (main list | to text | fzf)
  if ($name | is-empty) { return }
  $env.NVIM_APPNAME = $"nvim-($name)"
  nvim
}

def main [name?: string] {
  print $name
}
