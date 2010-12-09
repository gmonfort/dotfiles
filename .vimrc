set nocompatible
set nobackup
set directory=~/.vim/swap

" basic config
set number
set ruler

" Indentation
set smartindent
set autoindent

" Matching brackets
set showmatch
runtime! macros/matchit.vim

" Search config
set incsearch
set ignorecase
set hlsearch

set encoding=utf8
set tenc=utf8

if &modifiable
  set fileencoding=utf8
  set ff=unix
endif

" Disable F1 from opening the help
" I can type :help perfectly fine, thank you very much
imap <F1> <Esc>
nmap <F1> <Esc>

" use system registry by default
nnoremap y "+y
vnoremap y "+y
nnoremap Y "+Y
vnoremap Y "+Y
nnoremap p "+p
vnoremap p "+p
nnoremap P "+P
vnoremap P "+P
nnoremap d "+d
vnoremap d "+d
nnoremap D "+D
vnoremap D "+D
nnoremap x "+x
vnoremap x "+x
nnoremap X "+X
vnoremap X "+X
nnoremap c "+c
vnoremap c "+c
nnoremap C "+C
vnoremap C "+C

syntax on
filetype plugin indent on

augroup MyAutoCommands
  " Clear old autocmds in group
  autocmd!

  " File types
  autocmd BufRead,BufNewFile *.haml                     setfiletype haml
  autocmd BufRead,BufNewFile *.sass,*.scss              setfiletype sass
  autocmd BufRead,BufNewFile config.ru,Gemfile,Isolate  setfiletype ruby
  autocmd BufRead,BufNewFile *.liquid,*.mustache        setfiletype liquid

  " Ruby files
  autocmd FileType ruby,eruby,      set sw=2 ts=2 sts=2 et
  autocmd FileType ruby,eruby,haml  imap <buffer> <CR> <C-R>=RubyEndToken()<CR>

  autocmd FileType ruby             nnoremap <C-D> orequire "ruby-debug"; debugger; ""<Esc>

  " HTML/HAML
  autocmd FileType html,haml   set shiftwidth=2 softtabstop=2 expandtab

  " Javascript
  autocmd FileType javascript  set shiftwidth=4 softtabstop=4 expandtab

  " CSS
  autocmd FileType sass,css    set shiftwidth=2 softtabstop=2 expandtab

  " Other langs
  autocmd FileType python,php  set shiftwidth=4 softtabstop=4 expandtab

  " Vim files
  autocmd FileType     vim     set shiftwidth=2 softtabstop=2 expandtab
  autocmd BufWritePost .vimrc  source $MYVIMRC

  " Auto-wrap text in all buffers
  autocmd BufRead,BufNewFile * set formatoptions+=t
augroup END

" show tabs as blank-padded arrows, trailing spaces as middle-dots
set list
set listchars=tab:→\ ,trail:·
