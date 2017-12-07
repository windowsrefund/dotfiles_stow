" ~/.vimrc
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage itself, required
Plugin 'VundleVim/Vundle.vim'

" other plugins on github
Plugin 'jamessan/vim-gnupg'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'

" All plugins must be added before this line
call vundle#end()

filetype plugin indent on   " required


" settings according to categories defined in :options {{{1
" important {{{2
set nocompatible        " do not behave like vi
" moving around, searching and patterns {{{2
set incsearch           " highlight as we type
set showmatch           " highlight matching brackets, etc
set smartcase           " if caps, watch case
set ignorecase          " if all lowercase, ignore case
" tags {{{2

" displaying text {{{2
set number              " show the line number for each line
set linebreak           " wrap between words
if !&scrolloff
  set scrolloff=1       " always show this many lines at bottom when scrolling
endif
if !&sidescrolloff
  set sidescrolloff=5   " when 'nowrap' used, always show these many columns
endif
set wrap                " long lines wrap
set cmdheight=1         " number of lines used for the command-line
set list                " show <Tab> as ^I and end-of-line as $
set listchars=tab:>\ ,trail:~,extends:>,precedes:<,nbsp:+
set display+=lastline   " taken from sensible plugin
" syntax, highlighting and spelling {{{2
set hlsearch            " highlights search results
set background=dark
set cursorline
set cursorcolumn
set colorcolumn=80
" multiple windows {{{2
" set hidden                          " allow to bg unsaved buffers, etc
set laststatus=2                    " 0, 1 or 2; unsure what this really does
set statusline=
set statusline+=%<\ 
set statusline+=%F\                                       " file name
set statusline+=\ %h%m%r%w                                " flags
set statusline+=%=                                        " right align
set statusline+=fo=%{&fo}                                 " formatoptions
set statusline+=\ ft=%{&ft}                               " filetype
set statusline+=\ fenc=%{strlen(&fenc)?&fenc:'none'}      " encoding
" set statusline+=%{&ff}                                  " file format
set statusline+=\ %c,                                     " column
set statusline+=%l/%L                                     " line/total
set statusline+=\ %p%%\                                   " percent of file
" multiple tab panes {{{2
if exists("+showtabline")
  set tabline=%!MyTabLine()
endif
"
" terminal {{{2
"
" using the mouse {{{2
"
" printing {{{2
"
" message and info {{{2
set showcmd                         " show command sequences as typed
set shortmess=aoOtI
" selecting text {{{2
"
" editing text {{{2
set nrformats-=octal            " 0-prefixed numbers are still decimal
set backspace=indent,eol,start  " proper backspacing
set complete-=i                 " taken from sensible pluin???
set textwidth=79                " line length above which to break a line

                          " formatoptions - default is 'tcq'
                          " automatically insert the current comment
                          " leader after hitting <Enter> in Insert mode
set formatoptions+=r
set formatoptions+=n      " when formatting text, recognize numbered lists
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j    " delete comment character when joining line
endif
" tabs and indenting {{{2
set autoindent           " use same indentation as previous line
set smartindent          " makes autoindent even smarter
set smarttab             " a <Tab> in an indent inserts 'shiftwidth' spaces
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set shiftround           " round > and < to multiples of shiftwidth
" folding {{{2
set foldenable          " auto fold code
set foldmethod=marker
" diff mode {{{2
"
" mapping {{{2
set timeout                         " fixes slow O inserts
set timeoutlen=1000                 " fixes slow O inserts
set ttimeout                        " taken from sensible plugin
set ttimeoutlen=100                 " fixes slow O inserts
" reading and writing files {{{2
set nobackup
set autoread      " automattically read file when modified outside of Vim
" the swap file {{{2
set swapfile
" command line editing {{{2
set wildmenu
set wildmode=full
set noundofile
if &history < 1000
  set history=1000
endif
" executing external commands {{{2
"
" running make and jumping to errors {{{2
"
" language specific {{{2
"
" multi-byte characters {{{2
set encoding=utf-8      " used when displaying file
if &modifiable
  set fileencoding=utf-8  " used when writing file
endif
" various {{{2
set gdefault                  " use g flag with :substitute
set sessionoptions-=options   " taken from sensible plugin
if !empty(&viminfo)
  set viminfo^=!
endif
" mappings {{{1
" DO NOT COMMENT ON SAME LINE AS MAPPING

" formatting
nmap Q gq
vmap Q gq

" save keystrokes
nnoremap ; :

" yank from cursor to end of line
nnoremap Y y$

" use flags from previous :substitute
nnoremap & :&&<cr>

" edit config
nnoremap <leader>v :tabe $MYVIMRC<cr>

" disable highlights
nnoremap <leader><space> :noh<cr>

" spacebar toggles folding
nnoremap <space> za

" navigate to next/prev tab
nnoremap <c-n> gt
nnoremap <c-p> gT

" open new tab
nmap t <Plug>VinegarTabUp

" jump up and down across line wraps
nnoremap j gj
nnoremap k gk

" move up and down through context menu
"imap <Tab> <c-n>
"imap <s-Tab> <c-p>

" save the file using sudo
cmap w!! w !sudo tee % > /dev/null<cr>

" }}}1
" plugin settings {{{1

if v:version >= 700
  let g:is_bash = 1
endif
let g:mirodark_disable_color_approximation=1
let g:mirodark_enable_higher_contrast_mode=0
let g:GPGPreferArmor=1

" autocommands {{{1
if has("autocmd")
  autocmd BufNewFile,BufRead *.txt,README,INSTALL,NEWS,TODO if &ft == "" | set ft=text | endif

  " jump to last cursor position when opening a file
  autocmd BufReadPost * call setpos(".", getpos("'\""))

  augroup text
    autocmd!
    "autocmd Filetype text set formatoptions+=aw
    autocmd Filetype text,mail setlocal spell spelllang=en_us
  augroup END

  augroup vimscripts
    autocmd!
    autocmd BufWritePost $MYVIMRC,$MYVIMRC.local source $MYVIMRC
  augroup END

  augroup shellscripts
    autocmd Filetype sh let g:sh_fold_enabled=7
    autocmd Filetype sh set foldmethod=syntax
  augroup END

  augroup rubyfiles
    autocmd BufNewFile,BufRead Vagrantfile set ft=ruby
    autocmd Filetype ruby set foldmethod=syntax
    " TODO: add #/usr/bin/env ruby if a .rb extension
  augroup END

  augroup python_files
    au!
    au BufNewFile,BufRead *.py setlocal ft=python
    au BufNewFile *.py 0r ~/.vim/template-py | normal Go
    au FileType python setlocal tabstop=4
    au FileType python setlocal softtabstop=4
    au FileType python setlocal shiftwidth=4
    au FileType python setlocal textwidth=79
    au FileType python setlocal expandtab
    au FileType python setlocal autoindent
    au FileType python setlocal fileformat=unix
    au FileType python setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
    au BufWinLeave *.py setlocal foldexpr< foldmethod<
    au BufWritePre *.py if !filereadable(expand('%')) | let b:is_new = 1 | endif
    au BufWritePost *.py if get(b:, 'is_new', 0) | silent execute '!chmod +x %' | endif
  augroup END

endif
" functions {{{1
" MyTabLine {{{2
function! MyTabLine()
  let s = ''
  let t = tabpagenr()
  let i = 1
  while i <= tabpagenr('$')
    let buflist = tabpagebuflist(i)
    let winnr = tabpagewinnr(i)
    let s .= '%' . i . 'T'
    let s .= (i == t ? '%1*' : '%2*')
    let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
    let s .= i  . ': '
    let file = bufname(buflist[winnr - 1])
    let file = fnamemodify(file, ':p:t')
    if file == ''
      let file = '[No Name]'
    endif
    let s .= file
    let s .= ' '
    let i = i + 1
  endwhile
  let s .= '%T%#TabLineFill#%='
  let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
  return s
endfunction

" }}}
" }}}

filetype plugin indent on

" allow color schemes to do bright colors without forcing bold
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
else
  set t_Co=256         " number of colors
endif

" load matchit.vim, but only if the user hasn't installed a newer version
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

if filereadable(expand("$MYVIMRC.local"))
  source $MYVIMRC.local
endif

colorscheme mirodark
