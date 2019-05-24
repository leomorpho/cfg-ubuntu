set encoding=utf-8 

"set mouse=a
set number              " show line numbers 
set showcmd             " show command in bottom bar
set nocursorline        " highlight current line
set showmatch           " highlight matching parenthesis
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to (faster macros)

set foldenable          " enable folding (showall folds)
set foldnestmax=10
set foldmethod=indent
set foldlevel=3
" }}}
set expandtab shiftwidth=4 softtabstop=4 tabstop=8

" Make search case insensitive if all letters are in lower case
set ignorecase
" Make search case sensitive if some letters are in upper case
set smartcase

" Do not hide any markdown
set conceallevel=0
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 0

" Do not load last opened file
:let g:session_autoload = 'no'

" space folds code
nnoremap <space> za 
vnoremap <space> zf

map <C-n> :NERDTreeToggle<CR>

" Vim-Vuejs settings:
autocmd FileType vue syntax sync fromstart
let g:vue_disable_pre_processors = 1

" Make ag and ack live alongside
let g:ackprg = 'ag --nogroup --nocolor --column'

" Add fzf directory to @runtimepath
set rtp+=/usr/local/opt/fzf

" Reload init.vim on edits
if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd<Paste>

call plug#begin('~/.config/nvim/plugins/plugged')

" neovim Plugins {{{
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plug 'zchee/deoplete-jedi'
Plug 'tweekmonster/deoplete-clang2'
Plug 'roxma/nvim-yarp'			" Dependency of deoplete
Plug 'roxma/vim-hug-neovim-rpc'		" Dependency of deoplete

Plug 'donRaphaco/neotex', { 'for': 'tex' }
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'vim-utils/vim-man'
Plug 'janko-m/vim-test'
Plug 'ryanoasis/vim-devicons'
Plug 'w0rp/ale'
Plug 'kchmck/vim-coffee-script'
" Plug 'airblade/vim-gitgutter'
" }}}
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'fenetikm/falcon'
Plug 'mhartington/oceanic-next'
Plug 'joshdick/onedark.vim'
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'vim-scripts/cyclecolor'
Plug 'tomasr/molokai'
Plug 'fmoralesc/molokayo'

Plug 'vim-scripts/reload.vim'

Plug 'junegunn/goyo.vim', {'for':'markdown'}
autocmd! User goyo.vim echom 'Goyo is now loaded'

Plug 'junegunn/limelight.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'powerman/vim-plugin-autosess'

Plug 'mattn/emmet-vim'

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" Javascript and Vuejs
Plug 'posva/vim-vue'

" Add color to any css colors
Plug 'ap/vim-css-color'

" Add native Ack support to Vim
Plug 'mileszs/ack.vim'

" Code folding 
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/restore_view.vim'

" autoindent sometimes doesn't always do what you want (especially for PEP 8 standards).
" The following fixes that.
Plug 'vim-scripts/indentpython.vim'

" Syntax checking and highlighting for a bunch of languages
Plug 'vim-syntastic/syntastic'

" PEP 8 checking
Plug 'nvie/vim-flake8'

" Vim-airline status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File browsing
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Super searching
Plug 'kien/ctrlp.vim'

" Show thin vertical lines at each indentation level
Plug 'Yggdroot/indentLine'

Plug 'lervag/vimtex'
Plug 'matze/vim-tex-fold'

" Initialize plugin system
call plug#end()
"  }}}

" neo-vim remote 
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'
" To prevent conceal in LaTeX files
let g:tex_conceal = ''

"Syntastic settings {{{
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-m> :SyntasticCheck<CR> :SyntasticToggleMode<CR>
"}}}

" NerdTree settings {{{
" Open Nerdtree by default when no specific document is open
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists(“s:std_in”) | NERDTree | endif

" Automatically close nvim if only remaining tab is Nertree
" autocmd bufenter * if (winnr(“$”) == 1 && exists(“b:NERDTreeType”) && b:NERDTreeType == “primary”) | q | endif

" Hide .pyc files for nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Making Nerdtree prettier
" let NERDTreeMinimalUI = 1
" let NERDTreeDirArrows = 1

" Shortcut to open NERDtree
map <C-n> :NERDTreeToggle<CR>
" }}}


set termguicolors
" Change profile according to iTerm profile (for light and dark)
let iterm_profile = $ITERM_PROFILE
if iterm_profile == "dark"
    set background=dark
else
    set background=light
endif

syntax enable           " enable syntax processing

" Colorscheme will not work if before 'set termguiclors' above
" colorscheme CandyPaper 
colorscheme molokayo

" NERDTree Settings {{{
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
" call NERDTreeHighlightFile('py', 'Magenta', 'none', '#ff00ff', '#151515')
" }}}
:set cmdheight=1
set rtp+=/usr/local/opt/fzf

