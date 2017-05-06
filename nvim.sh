#Neovim Installation and setup
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt install neovim

echo Installing Plugin manager
mkdir ~/.config/nvim
mkdir ~/.config/nvim/autoload
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln .nvimrc ~/.config/nvim/init.vim
nvim +PlugInstall +qall
