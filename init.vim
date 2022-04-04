" ===
" === vim setting
" ===
set encoding=utf-8
set number
" set relativenumber
set ignorecase
set hidden
set updatetime=150
set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shortmess+=c

" ===
" === vim map
" ===
" Save & quit
nnoremap Q :q<CR>
nnoremap S :w<CR>

" map Esc
inoremap ;; <Esc>
vnoremap ;; <Esc>

" map start & end
nnoremap <C-h> ^
nnoremap <C-l> $
inoremap <C-h> <Esc>I
inoremap <C-l> <Esc>A
vnoremap <C-h> ^
vnoremap <C-l> $

" map leader to space 
let mapleader=" "
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
