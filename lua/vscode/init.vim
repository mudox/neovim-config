lua << EOF
do
  local p = package.path
  package.path = "/Users/mudox/Git/neovim-config/?.lua;" .. package.path
  require 'init'
  package.path = p
end
EOF