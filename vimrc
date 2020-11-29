syntax on
set expandtab
set cursorline
set number
set clipboard+=unnamed

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()
