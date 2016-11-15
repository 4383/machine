filetype plugin on
execute pathogen#infect()
set ignorecase
set ruler
set modeline
set number
set smartindent
set autoindent
set ruler
set mouse=a
set showcmd
set scrolloff=5
set undolevels=1000
set tabstop=4
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set background=dark
set nohlsearch
syntax on
filetype indent plugin on

"#########################################
" AutoCompletion python
"#########################################
let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict'
let g:pydiction_menu_height = 20

set list
colorscheme delek

map <C-t> :tabnew<CR>
map <C-h> :tabprevious<CR>
map <C-l> :tabnext<CR>
map <S-q> :tabclose<CR>
