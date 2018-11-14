set nocompatible
set nobackup
set nowb
set noswapfile

set directory^=~/.vim/swap//

set number
set ruler
set hidden
set mouse=a
set showcmd

" Indentation
set smartindent
set autoindent

" Search config
set incsearch
set noignorecase
set hlsearch

" Automatically reload files that have been changed outside vim
set autoread

set encoding=utf8
set tenc=utf8

set foldmethod=syntax
set foldlevelstart=999 " leave all folds open per default
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

" use system registry + the plus registry by default
set clipboard=unnamedplus
vnoremap <C-c> "+y
vnoremap <C-x> "+c
inoremap <C-v> <ESC>"+pa
vnoremap <C-v> c<ESC>"+p

" show tabs as blank-padded arrows, trailing spaces as middle-dots
set list
set listchars=tab:→\ ,trail:·

set tags=./tags,tags,~/commontags
set colorcolumn=+1        " highlight column after 'textwidth'
set background=dark

set modeline
set modelines=5

if has("gui_running")
  " set guifont=Monaco:h12  " use this font
  " set guifont=DejaVu\ Sans\ Mono\ Bold\ 10
  set guifont=DejaVu\ Sans\ Mono\ 9
  " highlight ColorColumn ctermbg=Grey guibg=grey10
  " colorscheme solarized
  colorscheme slate
else
  " let g:solarized_termcolors=256
  set t_Co=256
  colorscheme hilal
  " set clipboard=exclude:.*
endif


"
"" Mappings
"

" disable search highlight until the next search
nmap <Leader><Leader> :nohls<CR>

noremap <S-BS> :bdelete<CR>
noremap <S-Up> :bnext<CR>
noremap <S-Down> :bprev<CR>
noremap <C-t> :tabnew<CR>
noremap <C-Right> :tabnext<CR>
noremap <C-Left> :tabprevious<CR>

vnoremap s' "zdi'<C-R>z'<ESC>
vnoremap s" "zdi"<C-R>z"<ESC>
vnoremap < <gv
vnoremap > >gv

" Reindent the whole buffer
noremap <Leader>g gg=G``

execute pathogen#infect()

" Matchit
set showmatch
runtime! macros/matchit.vim

" Ctrl-P
set runtimepath^=~/.vim/bundle/ctrlp.vim

syntax on
filetype plugin indent on

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
    autocmd BufRead,BufNewFile config.ru,Gemfile          setfiletype ruby
  augroup END

  augroup ruby
    au!
    " autocmd FileType ruby,eruby   set omnifunc=rubycomplete#CompleteRuby
    " autocmd FileType ruby,eruby   set sw=2 ts=2 sts=2 foldlevel=99 et

    " Debugger
    autocmd FileType ruby         nnoremap <Leader>d obyebug<Esc>
    autocmd FileType haml         nnoremap <Leader>d o- buebug<Esc>
    autocmd FileType ruby,eruby   set noballooneval

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

" hi Normal guibg=black guifg=GhostWhite
" hi NonText guibg=black

set sw=2 ts=2 sts=2 et
