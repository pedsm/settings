set nocompatible              " be iMproved, required
set rtp+=/usr/local/opt/fzf
filetype off
set mouse=a

" new mappings use them
map <C-i> gg=G<C-o><C-o>zz:%s/\s\+$//e<CR>
map <F2> :NvimTreeToggle<CR>
" this allows for the usage of the system clipboard
map <F5> "+
imap jj <ESC>
nmap <F7> :TagbarToggle<CR>

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'scrooloose/nerdtree'
Plug 'goolord/alpha-nvim'
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'kyazdani42/nvim-tree.lua'
Plug 'tpope/vim-commentary'
Plug 'pedsm/vim-paragraph'
Plug 'lewis6991/gitsigns.nvim'
Plug 'dracula/vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kdheepak/tabline.nvim',
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_theme='deus'
Plug 'marko-cerovac/material.nvim'
Plug 'https://github.com/ryanoasis/vim-devicons'
" Plug 'https://github.com/adelarsq/vim-devicons-emoji' Too tacky
Plug 'airblade/vim-gitgutter'

" "Language support
" Plug 'udalov/kotlin-vim'
" Plug 'hsanson/vim-android'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Allow tab to traverse options in auto-complete window, refresh on backspace    
inoremap <silent><expr> <TAB>    
      \ pumvisible() ? "\<C-n>" :    
      \ <SID>check_back_space() ? "\<TAB>" :           
      \ coc#refresh()               
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"      
    
" Check if backspace was just pressed      
function! s:check_back_space() abort                    
  let col = col('.') - 1    
  return !col || getline('.')[col - 1]  =~# '\s'    
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <C-p> :GFiles<CR>
nmap <C-f> :FZF<CR>
nmap <C-S-f> :Rg<CR>

" Force FZF :Rg to not look at filenames
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)


command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Use K to show documentation in preview window.
"
map <C-a> :CocAction<CR>
nnoremap <silent> gD :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

call plug#end()

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\/node_modules$',
  \ }

set background=dark

filetype plugin indent on    " required
set wrapscan
set relativenumber
set number
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

"nvim
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
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
colorscheme dracula

" Lua stuff 
lua << EOF
require "ui"
require "core"
EOF
