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

" Colorscheme (Minimal, just to enhance readability)
syntax enable            " Enable syntax highlighting
set background=dark      " Use the dark background theme
colorscheme desert       " A neutral colorscheme

" Hide the mode indicator since Airline will show it
set noshowmode

" Key mappings for NERDTree
nnoremap &lt;C-n&gt; :NERDTreeToggle&lt;CR&gt; " Ctrl+n toggles file explorer

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