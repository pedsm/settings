set nocompatible              " be iMproved, required
filetype off
command! MakeTags !ctags -R .
command! CLatex !pdflatex %; rm *.aux; rm *.log; rm *.out; rm *.toc
command EditRC :e ~/.vimrc

"C++ header file
map <C-h> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
map <A-h> :sp %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

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
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'elzr/vim-json'
Plug 'digitaltoad/vim-pug'
Plug 'rust-lang/rust.vim'
" Plug 'leafgarland/typescript-vim'
"colours
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'

"nvim plguins
Plug 'Shougo/vimproc.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'pedsm/sprint'
Plug 'metakirby5/codi.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-clang'
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi'
Plug 'mhartington/nvim-typescript'
Plug 'landaire/deoplete-d'
Plug 'Quramy/tsuquyomi'
" Plug 'neomake/neomake'
Plug 'leafgarland/typescript-vim'
Plug 'w0rp/ale'
let g:ale_typescript_tslint_use_global = 1
"Deoplete master race
let g:deoplete#enable_at_startup = 1

call plug#end()

let g:onedark_termcolors=256
" let g:airline_theme = 'badwolf'
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:airline_theme = 'one'
let g:one_allow_italics = 1 " I love italic for comments
colorscheme onedark
" set background=dark " for the dark version


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
" let &t_Co=256

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
