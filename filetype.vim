" Neovim as manpager
au BufRead,BufNewFile   man://*      set filetype=man

" CocoaPods
au BufNewFile,BufRead Podfile,*.podspec,podfile.rb      setf ruby
