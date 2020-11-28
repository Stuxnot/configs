"        __                       __ 
"   ___ / /___ ____ __ ___  ___  / /_
"  (_-</ __/ // /\ \ // _ \/ _ \/ __/
" /___/\__/\_,_//_\_\/_//_/\___/\__/ 
" https://github.com/stuxnot
                                   
" #############################
" ### Table of Contents ###
"
" 1. General 
" 2. Plug-In
" 3. Keybindings
" 4. Editor
" 5. GUI
"
" Credit goes to:
" https://github.com/jonhoo/configs 
" https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
"
" #############################

" #############################
"
" General
"
" #############################

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

let mapleader = "\<space>"

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs 
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set nolbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines
set formatoptions-=o " disable comments on 'o' keypress


" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" ### Pesistent undo ###
try
    set undodir=~/.config/nvim/undodir
    set undofile
catch
endtry

" #############################
"
" Plug-In 
"
" #############################
if !exists('g:vscode')
call plug#begin('~/.config/nvim/plugged')

    " ###
    " GUI
    " ###
    Plug 'machakann/vim-highlightedyank' " highlights yanking
    Plug 'andymass/vim-matchup' " extends % with language specific matches

    Plug 'itchyny/lightline.vim' " status line

    Plug 'chriskempson/base16-vim' " colorscheme

    " ###
    " general improvements
    " ###
    Plug 'ciaranm/securemodelines'
    Plug 'tpope/vim-fugitive' 
    Plug 'airblade/vim-gitgutter'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " ###
    " Fuzzy finder
    " ###
    Plug 'airblade/vim-rooter'
    Plug 'junegunn/fzf.vim'

    " ###
    " language support
    " ###

    " Semantic language support
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Syntactic language support
    Plug 'rust-lang/rust.vim'
    Plug 'lervag/vimtex'
    Plug 'baskerville/vim-sxhkdrc'
    Plug 'rhysd/vim-clang-format'

call plug#end()

" vim-matchup 
let g:loaded_matchit = 1

" rooter settings
let g:rooter_patterns = ['!Makefile']

let g:lightline = {
            \ 'active': {
            \   'left': [ [ 'mode', 'paste'], 
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ] 
            \ },
            \ 'component_function': {
            \   'gitbranch': 'FugitiveHead'
            \ },       
            \ }


let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/ultisnips']

" airline settings
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1

" vimtex
let g:tex_flavor = "latex"
let g:vimtex_view_general_viewer = 'zathura'
let g:latex_viewer = 'mupdf'
let g:vimtex_quickfix_open_on_warning = 0

" securemodelines
let g:secure_modelines_allowed_items = [
                \ "textwidth",   "tw",
                \ "softtabstop", "sts",
                \ "tabstop",     "ts",
                \ "shiftwidth",  "sw",
                \ "expandtab",   "et",   "noexpandtab", "noet",
                \ "filetype",    "ft",
                \ "foldmethod",  "fdm",
                \ "readonly",    "ro",   "noreadonly", "noro",
                \ "rightleft",   "rl",   "norightleft", "norl",
                \ "colorcolumn"
                \ ]


" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
                                \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

endif
set updatetime=300

" #############################
"
" Keybindings
"
" #############################
nnoremap ; :
" Fast saving
nmap <leader>w :w<cr>

" jump to end and start of line
map H ^
map L $

nnoremap K i<cr><esc>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

if !exists('g:vscode')
" use gd, gy to jump to definitions
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)
nmap <leader>[  <Plug>(coc-diagnostic-prev)
nmap <leader>]  <Plug>(coc-diagnostic-next)

" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-r> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use rn for rename.
nmap <leader>rn <Plug>(coc-rename)

" fzf hotkeys
map <C-p> :Files<Cr>
nmap <leader>; :Buffer<Cr>

nmap <localleader>lt :call vimtex#fzf#run()<cr>
endif

" better copy and pasting to/from buffers
vmap <leader>y "+y
vmap <leader>d "+d
nmap <leader>y "+y
nmap <leader>d "+d
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" regex search
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" show hidden characters
nnoremap <leader>, :set invlist<cr>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" ### Buffer & Tabs ###
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :bdelete!<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" ### Spell checking ###
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

if !exists('g:vscode')
nmap <leader>fc :ClangFormat<Cr>
endif

" #############################
"
" Editor
"
" #############################
set wildmenu
set wildmode=list:longest

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" Set numbering and relative numbering
set relativenumber
set number

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" When searching try to be smart about cases
set smartcase
set ignorecase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" No annoying sound on errors
set noerrorbells
set novisualbell
set tm=500

set timeoutlen=200 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line

" Allow mouse usage
set mouse=a

" colored column 
set colorcolumn=80

" show partial commands
set showcmd

" show hidden characters
set nolist
set listchars=nbsp:¬,extends:»,precedes:«,trail:•,eol:¶

" always show column, so that errors don't shift everything
set signcolumn=yes

set nojoinspaces

" Splits open at the bottom and right
set splitbelow splitright

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

command! -nargs=0 CleanSpaces call CleanExtraSpaces()
if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.tex :call CleanExtraSpaces()
    " TODO: undo
    autocmd BufWritePre *.h,*.cpp,*.c :ClangFormat

    " Autocompile .Xresources
    autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
endif

" #############################
"
" GUI
"
" #############################

" Enable syntax highlighting
syntax on

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set utf8 as standard encoding 
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" deal with colors
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif

set guioptions-=T
set nofoldenable

" colorscheme using base16-vim
set background=dark
colorscheme base16-gruvbox-dark-hard
let base16colorspace=256
hi! Normal ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE

" Always show the status line
set laststatus=2
