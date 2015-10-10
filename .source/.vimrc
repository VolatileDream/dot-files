noremap t l
set wildmode=longest,list,full
set wildmenu

"Because not every machine has syntax turned on
if has("syntax")
  syntax on
endif

set showcmd         " Show (partial) command in status line.
set showmatch		" Show matching brackets.
set autowrite		" Automatically save before commands like :next and :make
set hidden	        " Hide buffers when they are abandoned

" Searching

set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hlsearch        " highlight matches


" Tabs

set tabstop=4		" number of visual spaces per TAB
set softtabstop=4	" number of spaces in tab when editing
set expandtab		" tabs are spaces


" For newline wrap
set showbreak=↪
" Git commits.
autocmd FileType gitcommit setlocal spell

" Colour scheme
colorscheme slate

" Check for pathogen plugins
call pathogen#infect()
if exists("g:loaded_pathogen")
  nnoremap <F5> :GundoToggle<CR>
endif


