set nocompatible            " disable compatibility to old-time vi
let mapleader = ","         " change leader key
set showmatch               " show matching 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
" set cc=120                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
" set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.

" Plugins
call plug#begin("~/.vim/plugged")
Plug 'dracula/vim'
Plug 'ryanoasis/vim-devicons'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'mhinz/vim-startify'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}
Plug 'Pocco81/AutoSave.nvim'
Plug 'vim-airline/vim-airline'
Plug 'lumiliet/vim-twig'
Plug 'leafOfTree/vim-svelte-plugin' 
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }
Plug 'dbakker/vim-projectroot'
Plug 'watzon/vim-edge-template'
Plug 'editorconfig/editorconfig-vim'
Plug 'mfussenegger/nvim-dap'
Plug 'dense-analysis/ale'
Plug 'jmcantrell/vim-virtualenv'
Plug 'yaegassy/coc-tailwindcss3', {'do': 'yarn install --frozen-lockfile'}
" Plug 'xdebug/vscode-php-debug', { 'do': 'npm install && npm run build' }
call plug#end()

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" Allow to search in vendor files
nnoremap <leader>fa <cmd>Telescope find_files no-ignore=true<cr>

" NerdTree 
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" display hidden files
let NERDTreeShowHidden=1 
" hide nerdtree after opened a file
let NERDTreeQuitOnOpen=1

" Airline 
let g:airline_powerline_fonts = 1
" Show buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" Coc
"let g:coc_filetype_map = {
"            \ 'twig': 'html'
"            \ }
"
" Coc extensions list
let g:coc_global_extensions = [
            \'coc-svelte',
            \'coc-snippets',
            \'coc-html-css-support',
            \'coc-html',
            \'coc-highlight',
            \'coc-eslint',
            \'coc-yaml',
            \'coc-tsserver',
            \'coc-phpactor',
            \'coc-php-cs-fixer',
            \'coc-json',
            \'coc-css',
            \'coc-pyright'
            \]

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use <c-space> to trigger completion.
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>i  <Plug>(coc-format-selected)
nmap <leader>i  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Custom shortcuts
" Close nvim
nnoremap <silent> <leader>q :q!<cr> 
" Save
nnoremap <silent> <leader>s :w!<cr> 

" Move between buffers
map <C-K> :bnext<CR>
map <C-J> :bprev<CR>
" Close current buffer
nnoremap <silent> <leader>bd :bd<cr>

" Clear highlighting
nnoremap <silent> <leader>h :noh<cr>

" Vim Svelte 
let g:vim_svelte_plugin_use_typescript = 1

" Vim debug
"if !exists('g:vdebug_options')
"    let g:vdebug_options = {}
"endif

"let g:vdebug_options["port"] = 9003
" Not stopping on the first line
"let g:vdebug_options["break_on_open"] = 0
" AutoSave
lua << EOF
local autosave = require("autosave")

autosave.setup(
{
    enabled = true,
    execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
    events = {"InsertLeave", "TextChanged"},
    conditions = {
        exists = true,
        filename_is_not = {},
        filetype_is_not = {"gitcommit"},
        modifiable = true
        },
    write_all_buffers = false,
    on_off_commands = true,
    clean_command_line_interval = 0,
    debounce_delay = 135
}
)
EOF

" Gitsigns
lua << EOF
require('gitsigns').setup {
    numhl = true,
    signcolumn = false,
    on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
    }
EOF

" vim commentary
setglobal commentstring=#\ %s
augroup comments
    autocmd!
    autocmd FileType twig setlocal commentstring={#\ %s
augroup END

" make sure .twig uses twig language and not django for example
autocmd BufNewFile,BufRead *.twig :set filetype=html

" PROJECTROOT : this is used to allow vdebug to be able to debug app in docker
" containers
let g:rootmarkers = ['.projectroot', 'docker-compose.yml', '.git']

" When nvim start, guess the working directory and set it as project root for
" vdebug.
" Note : Because I'm using ddev, the project is in /var/www/html. 
"function! SetupDebug()
"  let g:vdebug_options['path_maps'] = {'/var/www/html': call('projectroot#get', a:000)}
"  " Hack to override vdebug options
"  source ~/.vim/plugged/vdebug/plugin/vdebug.vim
"endfunction
"autocmd VimEnter * :call SetupDebug()

" nvim-dap
lua <<EOF
--[[local dap = require('dap')
dap.adapters.php = {
type = 'executable',
command = 'node',
args = { '~/.vim/plugged/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
{
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003,    
    pathMappings = {
    ['/var/www/html'] = "${workspaceFolder}", 
    },
  }
  }
--]]
EOF

" ALE for beautify files 
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'php': ['php_cs_fixer'],
\   'python': ['autopep8'],
\}
let g:ale_disable_lsp = 1
nnoremap <Leader>a :ALEFix<cr>
" Reload init.vim configuration
nnoremap <silent> <Leader><Leader>i :source $MYVIMRC<cr>
