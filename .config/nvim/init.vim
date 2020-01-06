set nu
inoremap jj <Esc>
set cindent

map <C-K> :pyf /usr/share/clang/clang-format-6.0/clang-format.py

filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
set mouse=a
set wildmenu
set path+=**

set splitbelow
set splitright
set cursorline
hi CursorLine   cterm=NONE ctermbg=16 ctermfg=NONE

"set rtp+=~/.config/nvim/bundle/Vundle.cim

let g:python_host_prog  = '/usr/bin/python'
let g:python3_host_prog  = '/usr/bin/python3'

call plug#begin('~/.local/share/nvim/plugged')
Plug 'ycm-core/YouCompleteMe'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'bling/vim-airline'
Plug 'arakashic/chromatica.nvim'
call plug#end()

autocmd BufNewFile,BufRead *.cu set filetype=cpp

" ycm config
let g:ycm_filetype_whitelist = {'python': 1, 'cpp': 1, 'txt': 1}
let g:ycm_confirm_extra_conf = 0
let g:ycm_python_binary_path = '/usr/bin/python'

" chromatica config
let g:chromatica#libclang_path='/home/deas/.local/share/nvim/plugged/YouCompleteMe/third_party/ycmd/third_party/clang/lib/libclang.so.8'

let mapleader=","
nnoremap <leader>gg :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gd :YcmCompleter GetDoc<CR>
nnoremap <leader>gt :YcmCompleter GetType<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
map <leader>n :nohl<CR>

