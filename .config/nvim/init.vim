syntax enable			" enable syntax processing
" colorscheme molokayo		" set theme
set termguicolors		

" -------------------------------------------------------->
"  Misc
set backspace=indent,eol,start	" modern backspace behaviour
set clipboard=unnamed		" copy to system's clipboard

" -------------------------------------------------------->
"  Spaces and Tabs
set tabstop=4			" 4 space tab
set expandtab			" use spaces for tabs
set softtabstop=4		" 4 space tab
set shiftwidth=4
set modelines=1 		" file-specific changes for nvim
filetype indent on
filetype plugin on
set autoindent

" -------------------------------------------------------->
"  UI Layout
set number              " show line numbers
set showcmd             " show command in bottom bar
set nocursorline        " highlight current line
set wildmenu
set lazyredraw
set showmatch           " highlight matching parenthesis
set fillchars=vert:\|

" -------------------------------------------------------->
"  Searching
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches

" -------------------------------------------------------->
"  Folding
set foldmethod=indent   " fold based on indent level
set foldnestmax=10      " max 10 depth
set foldenable          " don't fold files by default on open
nnoremap <space> za     
set foldlevelstart=10   " start with fold level of 1

" -------------------------------------------------------->
"  Autogroups
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.py setlocal tabstop=4
    autocmd BufEnter *.md setlocal ft=markdown
    autocmd BufEnter *.go setlocal noexpandtab
    autocmd BufEnter *.avsc setlocal ft=json
augroup END

" -------------------------------------------------------->
"  Backups
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" -------------------------------------------------------->
"  Keybindings
noremap <F5> :Autoformat<CR>
autocmd FileType python map <buffer> <F6> :call Flake8()<CR>
map <C-n> :NERDTreeToggle<CR>

" -------------------------------------------------------->
" Markdown
set conceallevel=0                  " Do not hide any markdown
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 0
:let g:session_autoload = 'no'      " Do not load last opened file


" -------------------------------------------------------->
"  Misc Functions
" Reload init.vim on edits
if has ('autocmd') " Remain compatible with earlier versions
    augroup vimrc     " Source vim configuration upon save
        autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
        autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
    augroup END
endif " has autocmd<Paste>

" -------------------------------------------------------->
"  Plugin Options
let g:ackprg = 'ag --nogroup --nocolor --column'    " Make ag and ack live alongside

" CtrlP options
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Use ag over grep for CtrlP if available
if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif


" -------------------------------------------------------->
"  Plugins

call plug#begin('~/.config/nvim/plugins/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
Plug 'zchee/deoplete-jedi'
Plug 'tweekmonster/deoplete-clang2'
Plug 'roxma/nvim-yarp'                  " Dependency of deoplete
Plug 'roxma/vim-hug-neovim-rpc'         " Dependency of deoplete

Plug 'donRaphaco/neotex', { 'for': 'tex' }
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} " Semantic highlighting for python
Plug 'vim-utils/vim-man'                " Man pages in neovim
Plug 'ryanoasis/vim-devicons'           " Add nerfont icons to all plugins
Plug 'w0rp/ale'                         " Check syntax and fix files asynchronously

" Themes
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

Plug 'junegunn/goyo.vim', {'for':'markdown'}
autocmd! User goyo.vim echom 'Goyo is now loaded'

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
" Plug 'vim-scripts/restore_view.vim'

" Indentation can be hell for python, therefore these 2 guys!
Plug 'nvie/vim-flake8'
Plug 'Chiel92/vim-autoformat'

" Syntax checking and highlighting for a bunch of languages
Plug 'vim-syntastic/syntastic'

" Fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'

" PEP 8 checking
Plug 'nvie/vim-flake8'

" Vim-airline status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File browsing
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Show thin vertical lines at each indentation level
Plug 'Yggdroot/indentLine'

Plug 'lervag/vimtex'
Plug 'matze/vim-tex-fold'

" Initialize plugin system
call plug#end()

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
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

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

" Add fzf directory to @runtimepath
set rtp+=/usr/local/opt/fzf
