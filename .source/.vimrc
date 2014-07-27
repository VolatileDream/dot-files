noremap t l
set wildmode=longest,list,full
set wildmenu

"Because not every machine has syntax turned on
if has("syntax")
  syntax on
endif
