" Directory for additional configuration files
if !isdirectory(expand('~/.config/nvim/config'))
    call mkdir(expand('~/.config/nvim/config'), 'p')
endif

" Source additional configuration files
" source ~/.config/nvim/config/mappings.vim
source ~/.config/nvim/config/plugins.vim
" source ~/.config/nvim/config/settings.vim
" source ~/.config/nvim/config/autocommands.vim

"-------------------------------
"-

" Initialize plugin system
call plug#end()

" Plugin-specific settings
if exists('g:loaded_onedark')
  if (has("autocmd") && !has("gui_running"))
    augroup colorset
      autocmd!
      let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
      autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " No bg color
    augroup END
  endif

  " OneDark settings
  let g:onedark_hide_endofbuffer = 1
  let g:onedark_terminal_italics = 1
  let g:onedark_termcolors = 256
endif


" init.vim - Minimal UI Enhancements

" Basic settings
set number               " Show line numbers
set relativenumber       " Show relative line numbers
set cursorline           " Highlight the current line
set showcmd              " Display incomplete commands
set ruler                " Show the cursor position all the time
set wildmenu             " Enable enhanced command line completion
set showmatch            " Highlight matching parenthesis
set incsearch            " Start searching as you type
set ignorecase           " Ignore case when searching...
set smartcase            " ...unless there is a capital letter in the query
set hlsearch             " Highlight search results
set updatetime=300       " Faster completion (default is 4000ms)
set signcolumn=yes       " Always show sign column to avoid text movements
set scrolloff=8          " Keep 8 lines visible above/below the cursor
set showtabline=2  " Always show the tab line

" Colorscheme (Minimal, just to enhance readability)
syntax enable            " Enable syntax highlighting
set background=dark      " Use the dark background theme
colorscheme desert       " A neutral colorscheme

" Hide the mode indicator since Airline will show it
set noshowmode

" Key mappings for NERDTree
" nnoremap &lt;C-n&gt; :NERDTreeToggle&lt;CR&gt; " Ctrl+n toggles file explorer
nnoremap <C-n> :NERDTreeToggle<CR> " Ctrl+n toggles file explorer

" Enable mouse support
set mouse=a " Enable mouse in all modes

" Better splits
set splitright           " Vertical splits open to the right
set splitbelow           " Horizontal splits open below

" Convenience settings
set clipboard=unnamedplus " Use the system clipboard
set noswapfile           " Disable swap files

" Airline Configuration (optional, can customize based on preference)
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='luna'

" Terminal colors
set termguicolors       " Enable true color support

" Colorscheme
syntax enable            " Enable syntax highlighting
set background=dark      " Use the dark background theme
silent! colorscheme onedark  " Use OneDark colorscheme, fail silently if not available" Terminal colors


" Indentation settings
set expandtab           " Use spaces instead of tabs
set shiftwidth=4        " Size of an indent
set softtabstop=4       " Number of spaces tabs count for in insert mode
set autoindent          " Copy indent from current line when starting a new line

" Highlight current line number
set cursorlineopt=number

" Enable persistent undo
set undofile
set undodir=~/.config/nvim/undodir

" Move 1 more lines up or down in normal and visual selection modes.
nnoremap K :m .-2<CR>==
nnoremap J :m .+1<CR>==
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" Set Up Buffer Navigation with Backslash
nnoremap <leader>bn :bnext<CR>     " Move to the next buffer
nnoremap <leader>bp :bprev<CR>     " Move to the previous buffer
nnoremap <leader>bd :bdelete<CR>   " Close the current buffer
nnoremap <leader>b :enew<CR>       " Open a new empty buffer
nnoremap <leader>r :bdelete!<CR>     " Close current buffer without saving (to manage open buffers)
nnoremap <leader>1 :buffer 1<CR>
nnoremap <leader>2 :buffer 2<CR>
nnoremap <leader>3 :buffer 3<CR>
nnoremap <leader>4 :buffer 4<CR>
nnoremap <leader>5 :buffer 5<CR>
nnoremap <leader>6 :buffer 6<CR>
nnoremap <leader>7 :buffer 7<CR>
nnoremap <leader>8 :buffer 8<CR>
nnoremap <leader>9 :buffer 9<CR>


" Set Up Buffer Navigation with Backslash
nnoremap <leader>t :tabnew<CR>     " Open a new tab
nnoremap <leader>tc :tabclose<CR>   " Close the current tab
nnoremap <leader>tn :tabnext<CR>    " Move to the next tab
nnoremap <leader>tp :tabprevious<CR> " Move to the previous tab
nnoremap <leader>t1 :tabn 1<CR>
nnoremap <leader>t2 :tabn 2<CR>
nnoremap <leader>t3 :tabn 3<CR>
nnoremap <leader>t4 :tabn 4<CR>

