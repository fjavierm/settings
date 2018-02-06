" Use Vundle to manage plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'darfink/vim-plist'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'scrooloose/nerdtree'
Plugin 'sentient-lang/vim-sentient'
Plugin 'skalnik/vim-vroom'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'

call vundle#end()

" Load these plugins before the rest of .vimrc
runtime! plugin/sensible.vim
runtime! plugin/jellybeans.vim

" Map comma as the leader key
let mapleader=","

set colorcolumn=81                " Draw a vertical bar after 80 characters
set encoding=utf-8                " Use UTF-8 by default
set expandtab                     " Use spaces instead of tabs
set hlsearch                      " Highlight search matches
set incsearch                     " Busqueda incremental
set ignorecase smartcase          " Make searches case insensitive
set list                          " List invisible characters
set nobackup                      " Don't create backup files
set noswapfile                    " Don't create swap files
set nowrap                        " Don't wrap long lines
set number                        " Show line numbers
set shiftwidth=2                  " Auto-indent using 2 spaces
set shortmess+=I                  " Hide the welcome message
set smartcase                     " (Unless they contain a capital letter)
set sts=2                         " Backspace deletes whole tabs at the end of a line
set t_Co=256                      " Use all 256 colours
set tabstop=2                     " A tab is two spaces long
set timeoutlen=300                " Leader key timeout is 300ms
set undodir=~/.vim/undo           " Store undo files in ~/.vim
set undofile                      " Persist undos between sessions
set wildmode=list:longest,full    " Autocompletion favours longer string
set pastetoggle=<leader>p

" Set status line to: filename [encoding,endings][filetype] ... col,line/lines
set statusline=%f\ [%{strlen(&fenc)?&fenc:'none'},%{&ff}]%y%h%m%r%=%c,%l/%L

" File types to ignore
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*,*/tmp/*
set wildignore+=*/.git/*,*/.rbx/*,*/.hg/*,*/.svn/*,*/.DS_Store
set wildignore+=*.swp,*~,._*

" Set file types for various extensions
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Procfile,*.ru,*.rake} set ft=ruby
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} set ft=markdown | set wrap
au BufRead,BufNewFile {*.json,.jshintrc,.eslintrc,*.pegjs} set ft=javascript

" Remember last location in a file, unless it's a git commit message
au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g`\"" | endif

" Strip trailing whitespace on write
function! <SID>StripTrailingWhitespace()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespace()

" Use the jellybeans colorscheme with some tweaks
let g:jellybeans_background_color_256=0
silent! color jellybeans
hi Search ctermfg=black ctermbg=yellow cterm=NONE
hi ColorColumn ctermbg=235
hi StatusLine ctermfg=white ctermbg=black
hi StatusLineNC ctermfg=gray ctermbg=black
hi TabLineFill ctermbg=235
hi TabLine ctermfg=gray ctermbg=235
hi TabLineSel ctermfg=white ctermbg=black

" Set git gutter colours
hi GitGutterAdd ctermfg=2
hi GitGutterChange ctermfg=3
hi GitGutterDelete ctermfg=1
hi GitGutterChangeDelete ctermfg=3

" Set git gutter line colours
hi GitGutterAddLine ctermfg=white ctermbg=22
hi GitGutterChangeLine ctermfg=white ctermbg=58
hi GitGutterChangeDeleteLine ctermfg=white ctermbg=58

" Show a larger number of matches in CtrlP
let g:ctrlp_max_height = 30

" Use git to speed up CtrlP file searches
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Use git to speed up global search
let g:ackprg = 'git grep -H --line-number --no-color'

" Highlight matches after a global search
let g:ackhighlight = 1

" Bind nerdtree to leader-n
nmap <leader>n :NERDTreeToggle<cr>

" Bind 'reveal' to leader-N
nmap <leader>N :NERDTreeFind<cr>

" Bind diff highlighting to leader-d
nmap <leader>d :GitGutterLineHighlightsToggle<cr>

" Bind global search to leader-f
nmap <leader>f :set hlsearch<cr>:Ack!<space>

" Bind macro @a in visual mode to m
vmap m :norm @a<cr>
