set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'jiangmiao/auto-pairs'
Plugin 'morhetz/gruvbox'
Plugin 'chrisbra/vim-commentary'
Plugin 'tomasr/molokai'
Plugin 'jnurmine/Zenburn'
call vundle#end()            " required
filetype plugin indent on    " required

autocmd filetype cpp nnoremap <F5> :w <bar> !g++ -ulimit -Wall -Wno-unused-result -std=c++20 -O2 % -o %:r && ./%:r < ./inp.txt <CR>
autocmd filetype cpp nnoremap <F6> :w <bar> !g++ -ulimit -Wall -Wno-unused-result -std=c++20 -O2 % -o %:r && ./%:r <CR>
syntax on
colorscheme zenburn
set nu
set clipboard=unnamedplus
set mouse=a
set tabstop=2
set autoindent
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab
set smartcase
set backspace=indent,eol,start
set t_Co=256
set background=dark
autocmd BufNewFile  *.cpp 0r ~/.vim/template/template.cpp 
