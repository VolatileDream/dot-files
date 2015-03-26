noremap t l
set wildmode=longest,list,full
set wildmenu

"Because not every machine has syntax turned on
if has("syntax")
  syntax on
endif

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned

" For newline wrap
set showbreak=↪
" Git commits.
autocmd FileType gitcommit setlocal spell

filetype plugin indent on

" Check for pathogen plugins
call pathogen#infect()
if exists("g:loaded_pathogen")
  nnoremap <F5> :GundoToggle<CR>
endif


