#!/usr/bin/env nu

let basedir = ($env.XDG_CONFIG_HOME | default ($env.HOME | path join ".config"))
let default_app = "nvim"

const PREFIX = 'nvim-app-'

def create-appname [base: string] {
  $PREFIX + $base
}

# def main [] {}

def "main list" [] {
  ls $basedir
}
def "main new" [] {}
def "main use" [] {}
def "main rm" [] {}
def "main edit" [] {}

def main [] {
  main list
}
