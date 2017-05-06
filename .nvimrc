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


call plug#begin('~/.vim/plugged')

" let Vundle manage Vundle, required
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'majutsushi/tagbar'
Plug 'ap/vim-css-color'
Plug 'ryanoasis/vim-devicons'
Plug 'terryma/vim-multiple-cursors'
Plug 'pedsm/vim-paragraph'
Plug 'editorconfig/editorconfig-vim'
"Language support
Plug 'scrooloose/syntastic'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'elzr/vim-json'
Plug 'digitaltoad/vim-pug'
Plug 'rust-lang/rust.vim'

" Vim 8.0 territory
if v:version >= 800
    Plug 'skywind3000/asyncrun.vim'
    Plug 'pedsm/sprint'
    Plug 'metakirby5/codi.vim'
endif

call plug#end()

set background=dark
"colorscheme molokai
let g:airline_theme = 'badwolf'


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
