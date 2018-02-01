noremap t l
set wildmode=longest,list,full
set wildmenu

set showcmd         " Show (partial) command in status line.
set autowrite		" Automatically save before commands like :next and :make
set hidden	        " Hide buffers when they are abandoned

" Searching

    set ignorecase		" Do case insensitive matching
    set smartcase		" Do smart case matching
    set incsearch		" Incremental search
    set hlsearch        " highlight matches

" Tabs

    set tabstop=2		" number of visual spaces per TAB
    set softtabstop=2	" number of spaces in tab when editing
    set expandtab		" tabs are spaces

" Fancy formatting things

    "Because not every machine has syntax highlighting available
    if has("syntax")
        syntax on
    endif

    set showbreak=↪         " on newline wrap, print this as beginning of next line
    set showmatch		" Show matching brackets.

    " Colour scheme
    colorscheme slate

" Git

    " On commit, spellcheck
    autocmd FileType gitcommit setlocal spell

