" plugins.vim - Plugin Configuration

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" List of plugins
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tidalcycles/vim-tidal'
Plug 'joshdick/onedark.vim'                " A dark color scheme
Plug 'sheerun/vim-polyglot'                " Better syntax highlighting
Plug 'jiangmiao/auto-pairs'                " Auto-close brackets, parentheses, etc.
Plug 'tpope/vim-commentary'                " Easy commenting
Plug 'airblade/vim-gitgutter'              " Git diff in the sign column
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                    " Fuzzy finder
" Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense engine (commented out until Node.js is installed)

" Initialize plugin system
call plug#end()

" OneDark settings
let g:onedark_hide_endofbuffer = 1
let g:onedark_terminal_italics = 1
let g:onedark_termcolors = 256

" Plugin-specific settings
if exists('g:loaded_onedark')
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " No bg color
  augroup END
endif