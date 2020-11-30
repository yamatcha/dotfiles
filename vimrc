syntax on
set expandtab
set cursorline
set number
set clipboard+=unnamed

" Completion  
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" theme
let g:airline_theme='icebergDark'
let g:tmuxline_theme = 'iceberg'

" plugin
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'gkeep/iceberg-dark'
Plug 'edkolev/tmuxline.vim'
call plug#end()

 
