default:
  @just --list --justfile {{justfile()}} --list-heading $'Neovim config recipes:\n' --list-prefix '  - '

# update neovim nightly
update-neovim-nightly:
  ${MDX_DOT_DIR}/ap/actions/update-neovim-nightly.zsh
