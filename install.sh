#!/bin/bash

set -e

# Until ubuntu default vim package support clipboard, we will be installing from custom PPA.
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update

# Install required system libraries
sudo apt install vim vim-gtk3 tmux git

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim \
    --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Create a symlink for .vimrc file
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf

# Install powerline fonts
git clone https://github.com/powerline/fonts
cd fonts
./install.sh
mkdir ~/.fonts
mv ~/.local/share/fonts/* ~/.fonts
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts/
mkdir ~/.config/fontconfig && mkdir ~/.config/fontconfig/conf.d/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

# Install tmux theme.
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack

vim +PlugInstall +qall

sudo apt install build-essential cmake python3-dev

cd ~/.vim/plugged/YouCompleteMe/
python3 install.py --clangd-completer --go-completer --rust-completer
