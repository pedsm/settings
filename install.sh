#!/bin/bash
echo Installing pedsm Settings
echo installing zsh and oh-my-zsh and tmux
sudo apt update
sudo apt install zsh tmux htop
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo Generating symlinks setting files
#sudo ln -s .atom ~/.
#sudo ln -s .vim ~/.vim
sudo ln .vimrc ~/.vimrc
sudo ln .zshrc ~/.zshrc
sudo ln .tmux.conf ~/.tmux.conf
echo Installing vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo Preparing neovim
mkdir -p ~/.config/nvim
