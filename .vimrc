set guifont=Menlo:h13
set background=dark
colorscheme desert

set nocompatible
set nobackup
set directory^=~/.vim/swap//

" basic config
set number
set ruler
set laststatus=2
" allow to hide unsaved buffers
set hidden
" enable mouse (for terminals that support it)
set mouse=a

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

" disable search highlight until the next search
nmap <Leader><Leader> :nohls<CR>

" buffer-navigation (analogous to tab-navigation)
nmap gb :bn<CR>
nmap gB :bp<CR>

" switchers
nmap <Leader>i :set ignorecase!<CR>
nmap <Leader>n :set number!<CR>
nmap <Leader>w :set wrap!<CR>

" switch between splits through f7 and f8
map <f8> <c-w>j<c-w>_
imap <f8> <esc><f8>

map <f7> <c-w>k<c-w>_
imap <f7> <esc><f7>

" use system registry by default
set clipboard=unnamed

call pathogen#runtime_append_all_bundles()

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
  autocmd FileType cucumber         set sw=2 ts=2 sts=2 et
  autocmd FileType ruby,eruby,      set sw=2 ts=2 sts=2 et
  autocmd FileType ruby,eruby,      imap <buffer> <CR> <C-R>=RubyEndToken()<CR>

  autocmd FileType ruby             nnoremap <Leader>d orequire "ruby-debug"; debugger; ""<Esc>
  autocmd FileType ruby             nnoremap <Leader>D Orequire "ruby-debug"; debugger; ""<Esc>

  " HTML/HAML
  autocmd FileType html,haml   set shiftwidth=2 softtabstop=2 expandtab

  autocmd FileType haml        nnoremap <Leader>d o- require "ruby-debug"; debugger; ""<Esc>
  autocmd FileType haml        nnoremap <Leader>D O- require "ruby-debug"; debugger; ""<Esc>

  " Javascript
  autocmd FileType javascript  set shiftwidth=2 softtabstop=2 expandtab

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

