#!/bin/bash
echo Installing pedsm Settings
echo installing brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install neovim
echo Generating symlinks setting files
sudo ln -s .vim ~/.vim
sudo ln .zshrc ~/.zshrc
cp -r .oh-my-zsh ~/.oh-my-zsh/
cp .oh-my.zsh/custom/themes/vercel.zsh-theme ~/.oh-my-zsh/custom/themes/ 
echo copying .vim
mkdir -p ~/.config/nvim || true
sudo cp -r .vim/ ~/.config/nvim/

