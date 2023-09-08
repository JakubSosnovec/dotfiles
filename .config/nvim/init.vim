inoremap jj <Esc>

filetype plugin indent on

set nu
set cindent
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set wildmenu
set completeopt=menu,menuone,noinsert,noselect
set path+=**
set splitbelow
set splitright
set cursorline

set hlsearch
set incsearch
set ignorecase " Ignore case by default...
set smartcase " ...unless upper-case is used

" https://www.davidspencer.xyz/posts/neovim-as-an-ide-python/
set undodir=~/.cache/nvim/undo  "undo ability will persist after exiting file
set undofile                    "see :help undodir and :help undofile
set showmatch                   "display matching bracket or parenthesis
set noswapfile

call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'bling/vim-airline'

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'petertriho/cmp-git' " This should provide interesting autocompletion in `git commit` buffers??
Plug 'mhartington/formatter.nvim'
Plug 'astral-sh/ruff-lsp'


Plug 'nvim-treesitter/nvim-treesitter'
Plug 'mhartington/oceanic-next'
call plug#end()

" Theme
syntax enable
colorscheme OceanicNext
let g:airline_theme='oceanicnext'

let mapleader=","

"Un-highlight
nnoremap <leader>n :nohl<CR>
"Switch to previous buffer
nnoremap <leader>s :b#<CR>

"Find files
nnoremap <leader>f :Files<CR>
"Find files that are not git-ignored
nnoremap <leader>g :GFiles<CR>
"Find files that are open in buffers
nnoremap <leader>b :Buffers<CR>
"Search in current buffer
nnoremap <leader>l :BLines<CR>
"History of open files in nvim
nnoremap <leader>h :History<CR>
"History of commands
nnoremap <leader>c :History:<CR>
"Search recursively in all sub-directories
nnoremap <leader>a :Rg<CR>
"Apply black code formatter
"Disabling in favour of formatter.nvim
"nnoremap <leader>k :!black %<CR>

lua require('lua_config')

"Using formatter.nvim
nnoremap <silent> <leader>k :Format<CR>
nnoremap <silent> <leader>K :FormatWrite<CR>

