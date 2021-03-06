set nocompatible              " be iMproved, required
filetype off
command! MakeTags !ctags -R .
command! CLatex !pdflatex %; rm *.aux; rm *.log; rm *.out; rm *.toc
command EditRC :e ~/.vimrc

"Easter eggs
command! Weather !curl -4 wttr.in
command! Moon !curl -4 wttr.in/Moon

" new mappings use them
map <C-i> gg=G<C-o><C-o>zz:%s/\s\+$//e<CR>
map <F2> :NERDTree<CR>
" this allows for the usage of the system clipboard
map <F5> "+
imap jj <ESC>
nmap <F7> :TagbarToggle<CR>

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
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'majutsushi/tagbar'
Plugin 'SearchComplete'
Plugin 'ap/vim-css-color'
Plugin 'ryanoasis/vim-devicons'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'pedsm/vim-paragraph'
Plugin 'editorconfig/editorconfig-vim'
"Language support
Plugin 'scrooloose/syntastic'
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'elzr/vim-json'
Plugin 'digitaltoad/vim-pug'
Plugin 'rust-lang/rust.vim'

" Snippets for days
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
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
endif


set background=dark
colorscheme molokai
let g:airline_theme = 'badwolf'
" Gvim set up
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
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

"Airline settings
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

"nvim
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

syntax enable
filetype plugin indent on
