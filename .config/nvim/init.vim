set nu
set cindent
set tabstop=4
set shiftwidth=4
set mouse=a
set wildmenu
set path+=**
set expandtab
set splitbelow
set splitright
set cursorline
set hlsearch
set noswapfile
set completeopt=menu,menuone,noinsert,noselect

filetype plugin indent on

hi CursorLine   cterm=NONE ctermbg=16 ctermfg=NONE

let g:python_host_prog  = '/usr/bin/python'
let g:python3_host_prog  = '/usr/bin/python3'

call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'bling/vim-airline'
Plug 'vim-scripts/DoxygenToolkit.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-omni'
Plug 'hrsh7th/nvim-cmp'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'mhartington/oceanic-next'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
call plug#end()

" Theme
syntax enable
colorscheme OceanicNext
let g:airline_theme='oceanicnext'

map <C-K> :py3f /usr/share/clang/clang-format-10/clang-format.py

let mapleader=","
inoremap jj <Esc>
"Un-highlight
nnoremap <leader>n :nohl<CR>
"Switch to previous buffer
nnoremap <leader>s :b#<CR>
"Find files that are not git-ignored, use :Files to search all
nnoremap <leader>f :GFiles<CR>
"Find files that are open in buffers
nnoremap <leader>b :Buffers<CR>
"Search in current buffer
nnoremap <leader>l :BLines<CR>
"History of open files in nvim
nnoremap <leader>h :History<CR>
"History of commands
nnoremap <leader>c :History:<CR>
"Search recursively in all sub-directories
nnoremap <leader>a :Ag<CR>

"In visual mode, you can hit / to Ag-search for the selected text
vnoremap / y:Ag \V<C-R>=escape(@",'/\')<CR><CR>

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-n>'] = cmp.mapping({
          c = function()
              if cmp.visible() then
                  cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                  vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
              end
          end,
          i = function(fallback)
              if cmp.visible() then
                  cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                  fallback()
              end
          end
      }),
      ['<C-p>'] = cmp.mapping({
          c = function()
              if cmp.visible() then
                  cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                  vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
              end
          end,
          i = function(fallback)
              if cmp.visible() then
                  cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                  fallback()
              end
          end
      }),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      --{ name = 'vsnip' }, -- For vsnip users.
      { name = 'omni' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Diagnostic mappings
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gf', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts) -- I dont use this
    vim.keymap.set('n', '<C-l>', vim.lsp.buf.signature_help, bufopts) -- I dont use this
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts) -- I dont use this
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts) -- I dont use this
    vim.keymap.set('n', '<space>wl', function() -- I dont use this
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts) -- I dont use this, probably same as clang-format
  end

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['clangd'].setup {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--completion-style=bundled",
      "--cross-file-rename",
      "--header-insertion=iwyu",
    },
    capabilities = capabilities,
    on_attach = on_attach
  }
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities,
    on_attach = on_attach
  }

  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "cpp", "lua", "bash", "cmake", "python" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = true,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { "javascript" },

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
  }
EOF
