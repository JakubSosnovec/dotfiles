set nu
inoremap jj <Esc>

set cindent

map <C-K> :pyf /usr/share/clang/clang-format.py
imap <C-K> <c-o>:pyf /usr/share/clang/clang-format.py

filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
set mouse=a
set wildmenu
set path+=**
