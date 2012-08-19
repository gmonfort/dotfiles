set nocompatible
set nobackup
set nowb
set noswapfile

set directory^=~/.vim/swap//

" basic config
set number
set ruler
" allow to hide unsaved buffers
set hidden
" enable mouse (for terminals that support it)
set mouse=a
set showcmd

set sw=2 ts=2 sts=2 et

" Indentation
set smartindent
set autoindent

" Matching brackets
set showmatch
runtime! macros/matchit.vim

" Search config
set incsearch
set noignorecase
set hlsearch

" Automatically reload files that have been changed outside vim
set autoread

set encoding=utf8
set tenc=utf8

set foldmethod=syntax
set foldlevelstart=99 " leave all folds open per default
set formatoptions=qrct

set guioptions-=T " no toolbar
set guioptions-=m " no menus
set guioptions-=a " do NOT automatically yank selection to "* register on visual selections

" Statusline
set laststatus=2 "Always show statusline
set statusline=
set statusline+=%2*%-3.3n%0*\                 " buffer number
set statusline+=%F\                           " file name
set statusline+=%2*                           " black background
set statusline+=%=                            " right align
set statusline+=%h%m%r%w                      " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{&encoding},                 " encoding
set statusline+=%{&fileformat}]               " file format
set statusline+=\ %0*                         " end of black background
set statusline+=%2*%-14.(%l,%c%V%)\ %<%0*\ %P " offset
set noerrorbells visualbell t_vb=

if &modifiable
  set fileencoding=utf8
  set ff=unix
endif

" use system registry by default
set clipboard=unnamed

" show tabs as blank-padded arrows, trailing spaces as middle-dots
set list
set listchars=tab:→\ ,trail:·

set tags=./tags,tags,~/commontags

if has("gui_running")
  colorscheme railscasts
else
  colorscheme desert
endif

"
"" Mappings
"

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

noremap <C-BS> :bdelete<CR>
noremap <S-Up> :bnext<CR>
noremap <S-Down> :bprev<CR>
noremap <F1> :E<CR>
noremap <F9> :source ~/.vimrc<CR>
noremap <S-F9> :e ~/.vimrc<CR>

vnoremap s' "zdi'<C-R>z'<ESC>
vnoremap s" "zdi"<C-R>z"<ESC>
vnoremap < <gv
vnoremap > >gv

" Reindent the whole buffer
noremap <Leader>g gg=G``

" Execute current line as a vim script
nnoremap <Leader>e "ayy :@a<CR>


call pathogen#infect()

syntax on
filetype plugin indent on

if has("gui_running")
  set guifont=Monospace\ 11  " use this font
else
  " colorscheme elflord    " use this color scheme
  " set background=dark    " adapt colors for background
endif

if has("autocmd")
  filetype plugin on
  " augroup bufEnter
  "    au!
  "    au BufEnter * :cd %:p:h
  " augroup END

  autocmd GUIEnter *
          \ set visualbell t_vb=

  augroup generic
    au!
    autocmd BufRead,BufNewFile *.haml                     setfiletype haml
    autocmd BufRead,BufNewFile *.sass,*.scss              setfiletype sass
    autocmd BufRead,BufNewFile config.ru,Gemfile,Isolate  setfiletype ruby
    autocmd FileType javascript  set sw=2 ts=2 sts=2 et
    autocmd FileType sass,css    set sw=2 ts=2 sts=2 et
  augroup END

  augroup python
    au!
    autocmd FileType python set omnifunc=pythoncomplete#CompletePython
    autocmd FileType python set sw=2 ts=2 sts=2
  augroup END

  augroup ruby
    au!
    "autocmd FileType ruby,eruby   set omnifunc=rubycomplete#CompleteRuby
    autocmd FileType cucumber     set sw=2 ts=2 sts=2 et
    autocmd FileType ruby,eruby   set sw=2 ts=2 sts=2 foldlevel=10 et
    autocmd FileType ruby,eruby   imap <buffer> <CR> <C-R>=RubyEndToken()<CR>

    " HTML/HAML
    autocmd FileType html,haml    set sw=2 ts=2 sts=2 et

    " Debugger
    autocmd FileType ruby         nnoremap <Leader>d orequire "debugger"; debugger; ""<Esc>
    autocmd FileType ruby         nnoremap <Leader>D Orequire "debugger"; debugger; ""<Esc>
    autocmd FileType haml         nnoremap <Leader>d o- require "debugger"; debugger; ""<Esc>
    autocmd FileType haml         nnoremap <Leader>D O- require "debugger"; debugger; ""<Esc>
  augroup END

  augroup vimrcEx
    au!
    autocmd FileType text setlocal textwidth=78
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif
    autocmd BufWritePost .vimrc  source $MYVIMRC
  augroup END
endif

let g:directory = "~/code"
function! Chdir(arg)
  :exec 'cd ' a:arg
  :exec 'Ex ' a:arg
endfunction
noremap <S-F1> :call Chdir(g:directory)<CR>

hi Normal guibg=black guifg=GhostWhite
hi NonText guibg=black

" some TIPS:
"
" '. --> nos lleva a la ultima linea modificada
" :bufdo %s/buscar/reemplazar/ge  : Reemplaza la cadena en todos los buffers
" :bufdo comando                  : Ejecuta el comando en toda la lista de buffers.
" :tab sba                        : Pone en pestañas todos los buffers.
" ha!                             : Imprime el buffer actual por la impresora predeterminada.
" :bufdo /searchstr/              : Search in all open buffers
" :g/string/d                     : Delete all lines containing ?string?
" Vu                              : Lowercase line
" VU                              : Uppercase line
" g~~                             : Invert case
" :%s/\<./\u&/g                   : Sets first letter of each word to uppercase (\l for lowercase)
" :%s/.*/\u&                      : Sets first letter of each line to uppercase
" gf                              : Open file name under cursor
"
" guu                             : lowercase line
" gUU                             : uppercase line
" ~                               : invert case (upper->lower; lower->upper) of current character
"
" AUTOCOMPLETE
" <C-N> <C-P>                     : word completion in insert mode
" <C-X><C-L>                      : Line complete
"
" TAGS
" :tag getUser                    : Jump to getUser method
" :tn (or tnext)                  : go to next search result
" :tp (or tprev)                  : to to previous search result
" :ts (or tselect)                : List the current tags 
"
" EXEC
" :.!sh                           : Execute contents of current line in buffer and capture the output
" !!                              : in normal mode, equivalent to :.!
" :r!ls                           : reads in output of ls

" "au BufWritePost   *.sh !chmod +x %
