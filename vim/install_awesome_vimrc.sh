#!/bin/sh
set -e

echo '
source ~/.dotfiles/vim/vimrcs/basic.vim
source ~/.dotfiles/vim/vimrcs/filetypes.vim
source ~/.dotfiles/vim/vimrcs/plugins_config.vim
source ~/.dotfiles/vim/vimrcs/extended.vim
' > ~/.vimrc

echo "Installed the Ultimate Vim configuration successfully! Enjoy :-)"
