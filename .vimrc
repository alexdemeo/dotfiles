colorscheme desert

" activates filetype detection
filetype plugin indent on

" activates syntax highlighting among other things
syntax on

" allows you to deal with multiple unsaved
" buffers simultaneously without resorting
" to misusing tabs
set hidden

" just hit backspace without this one and
" see for yourself
set backspace=indent,eol,start

set tabstop=4
set shiftwidth=4
set expandtab

set number
set relativenumber

nnoremap '<C-d>' '<C-d>zz'
nnoremap '<C-u>' '<C-u>zz'

