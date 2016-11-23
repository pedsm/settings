#!/bin/bash
echo Installing pedsm Settings
echo installing zsh and oh-my-zsh and tmux
sudo apt update
sudo apt install zsh tmux htop
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo Copying setting files
sudo cp -r .vim ~/.vim
sudo cp -r .vimrc ~/.vimrc
sudo cp -r .zshrc ~/.zshrc
sudo cp -r .tmux.conf ~/.tmux.conf
echo Installing vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
~/.vim/bundle/YouCompleteMe/install.py
