set nocompatible              " be iMproved, required
filetype off
command! MakeTags !ctags -R .
command! CLatex !pdflatex %; rm *.aux; rm *.log; rm *.out; rm *.toc
command! CPhp !php %
" OP Easter eggs
command! Weather !curl -4 wttr.in
command! Moon !curl -4 wttr.in/Moon
" end of easter eggs
command Lorem :-1read ~/home/pedro/.vim/.skeleton/lorem.txt<CR>
command EditRC :e ~/.vimrc
" new mappings use them
map <C-i> gg=G<C-o><C-o>zz:%s/\s\+$//e<CR>
map <F2> :NERDTree<CR>
" this allows for the usage of the system clipboard
map <F5> "+
imap jj <ESC>
nmap <F7> :MakeTags <CR> :TagbarToggle<CR>

"presentation VIM MODE
" map <F2> <PageDown>
" map <F3> <PageUp>
" map <F4> >>gUU
" map <F5> u


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'pangloss/vim-javascript'
Plugin 'mattn/emmet-vim'
Plugin 'kchmck/vim-coffee-script'
Plugin '2072/PHP-Indenting-for-VIm'
Plugin 'majutsushi/tagbar'
Plugin 'elzr/vim-json'
Plugin 'SearchComplete'
Plugin 'ap/vim-css-color'
Plugin 'ryanoasis/vim-devicons'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/syntastic'
Plugin 'pedsm/vim-paragraph'
" Snippets for days
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Plugin 'editorconfig/editorconfig-vim'
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="`"
let g:UltiSnipsJumpForwardTrigger="="
let g:UltiSnipsJumpBackwardTrigger="-"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" Vim 8.0 territory
if v:version >= 800
    Plugin 'skywind3000/asyncrun.vim'
    Plugin 'pedsm/sprint'
    Plugin 'metakirby5/codi.vim'
    Plugin 'w0rp/ale'
endif


set background=dark
colorscheme molokai
let g:airline_theme = 'badwolf'
" Gvim set up
set guioptions-=T
set gfn=Ubuntu\ Mono\ derivative\ Powerline\ 14

"Plugin 'file://home/pedro/Dev/vim-powerline/plugin/Powerline.vim'

call vundle#end()            " required
filetype plugin indent on    " required
set wrapscan
set relativenumber
set expandtab
set softtabstop=4
set shiftwidth=4
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set encoding=utf-8 " Necessary to show Unicode glyphs
" set listchars=tab:>-,trail:_ list
set hlsearch
set noshowmode
let &t_Co=256

let g:AutoPairsFlyMode = 0
let g:Powerline_symbols = 'fancy'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 1
" let g:airline_left_sep = '▙'
" let g:airline_right_sep = '▟'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'


let g:airline#extensions#tabline#enabled = 1


syntax enable
filetype plugin indent on
