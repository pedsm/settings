all:
	sudo apt install zsh
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
	cp -r .vim ~/.vim
	cp -r .vimrc ~/.vimrc
	cp -r .zshrc ~/.zshrc
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	./.vim/bundle/YouCompleteMe/install.py
