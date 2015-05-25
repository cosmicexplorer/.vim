" Eevee's vimrc

"" FIXING INPUT ERRORS ON XTERM
imap  
cmap  

function! CheckIfRoot()
python << endpython
import os, vim

if (os.getenv('HOME') == '/root'):
    vim.command('return 0')
    vim.command('return 1')
endpython
endfunction

if CheckIfRoot()
    set runtimepath+=/usr/share/vim
endif

" vim mode preferred!
set nocompatible

" set xterm title, and inform vim of screen/tmux's syntax for doing the same
set titlestring=vim\ %{expand(\"%t\")}
if &term =~ "^screen"
" pretend this is xterm. it probably is anyway, but if term is left as
" `screen`, vim doesn't understand ctrl-arrow.
    if &term == "screen-256color"
        set term=xterm-256color
    else
        set term=xterm
    endif

" gotta set these *last*, since `set term` resets everything
    set t_ts=k
    set t_fs=\
endif
set title

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" backups and other junky files
set nobackup " backups are annoying
set writebackup " temp backup during write
" TODO: backupdir?
set undodir=~/.vim/undo " persistent undo storage
set undofile " persistent undo on

" user interface
set history=1000 " remember command mode history
set laststatus=2 " always show status line
set lazyredraw " don't update screen inside macros, etc
set matchtime=2 " ms to show the matching paren for showmatch
set number " line numbers
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set showmatch " show matching brackets while typing
set relativenumber " line numbers spread out from 0
set cursorline " highlight current line
set display=lastline,uhex " show last line even if too long; use <xx>

" regexes
set incsearch " do incremental searching
set ignorecase " useful more often than not
set smartcase " case-sens when capital letters

" whitespace
set autoindent " keep indenting on <CR>
set shiftwidth=4 " one tab = four spaces (autoindent)
set softtabstop=4 " one tab = four spaces (tab key)
set expandtab " never use hard tabs
set shiftround " only indent to multiples of shiftwidth
set smarttab " DTRT when shiftwidth/softtabstop diverge
set fileformats=unix,dos " unix linebreaks in new files please
" appearance of invisible characters

" wrapping
"set colorcolumn=+1 " highlight 81st column
set linebreak " break on what looks like boundaries
"set textwidth=80 " wrap after 80 columns


" gui stuff
set ttymouse=xterm2 " force mouse support for screen
set mouse=a " terminal mouse when possible
set guifont=Source\ Code\ Pro\ 9
" nice fixedwidth font

" unicode
set encoding=utf-8 " best default encoding
setglobal fileencoding=utf-8 " ...
set nobomb " do not write utf-8 BOM!
set fileencodings=ucs-bom,utf-8,iso-8859-1
" order to detect Unicodeyness

" tab completion
set wildmenu " show a menu of completions like zsh
set wildmode=full " complete longest common prefix first
set wildignore+=.*.sw*,__pycache__,*.pyc
" ignore junk files
set complete-=i " don't try to tab-complete #included files
set completeopt-=preview " preview window is super annoying

" miscellany
set autoread " reload changed files
set scrolloff=2 " always have 2 lines of context on the screen
set foldmethod=indent " auto-fold based on indentation. (py-friendly)
set foldlevel=99
set timeoutlen=1000 " wait 1s for mappings to finish
set ttimeoutlen=100 " wait 0.1s for xterm keycodes to finish
set nrformats-=octal " don't try to auto-increment 'octal'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
" Pathogen; load all bundles
filetype off " uh, necessary
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" SuperTab and tab completion; use omni completion but
"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
set omnifunc=syntaxcomplete#Complete
"autocmd FileType *
"    \ call SuperTabChain(&omnifunc, "<c-p>") |
"    \ call SuperTabSetDefaultCompletionType("<c-x><c-u>")

" Python-mode; linting is kind of annoying, so tame it
let g:pymode_lint_checker = "pyflakes"
let g:pymode_lint_cwindow = 0

" Airline; use powerline-style glyphs and colors
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'

" Ctrl-P settings
let g:ctrlp_custom_ignore = { 'dir': '\v[\/](build|[.]git)$' }
let g:ctrlp_max_files = 50000 " i work on a project with a lot of files.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bindings
" Stuff that clobbers default bindings
" Force ^U and ^W in insert mode to start a new undo group
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

" Leader
let mapleader = ","
let g:mapleader = ","

" Swaps selection with buffer
vnoremap <C-X> <Esc>`.``gvP``P

" ctrl-arrow in normal mode to switch windows; overrides ctrl-left/right for
" moving by words, but i tend to use those only in insert mode
noremap <C-Left> <C-W><Left>
noremap <C-Right> <C-W><Right>
noremap <C-Up> <C-W><Up>
noremap <C-Down> <C-W><Down>

" -/= to navigate tabs
noremap - :tabprevious<CR>
noremap = :tabnext<CR>

" Bind gb to toggle between the last two tabs
map gb :exe "tabn ".g:ltv<CR>
function! Setlasttabpagevisited()
    let g:ltv = tabpagenr()
endfunction

augroup localtl
au!
autocmd TabLeave * call Setlasttabpagevisited()
augroup END
autocmd VimEnter * let g:ltv = 1

" Abbreviation to make `:e %%/...` edit in same directory
cabbr <expr> %% expand('%:.:h')

" yeah shift key just try to fuck with me
" (makes gr go backwards with tabs)
nmap gr gT
" use tab and shift+tab to switch tabs like a fucking normal human being
nmap <C-Tab> gt
nmap <C-S-Tab> gT

" FUCK WITH ME SPLIT SCREEN
" (makes ctrl+arrow key move around screens)
map <C-Left> <C-W><C-H>
map <C-Right> <C-W><C-L>
map <C-Down> <C-W><C-J>
map <C-Up> <C-W><C-K>
" EVEN COOLER SPLIT SCREEN NAVIGATION
nmap de <C-W><C-K>
nmap ds <C-W><C-H>
nmap dc <C-W><C-J>
nmap df <C-W><C-L>

" so i can do that cool emacs thing with terminals in a split window
cabbr bash ConqueTerm bash
cabbr zsh ConqueTerm zsh

" quickly move to front and back of tabs
nmap gq :tabfir<CR>
nmap gp :tabl<CR>

" tab-complete stuff like xcode/visual studio
imap <Tab> <C-P>

" show undo tree
nnoremap tt :GundoToggle<CR>

" turn on hex editing mode
nnoremap hh :Hexmode<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" functions n such


" ex command for toggling hex mode - define mapping if desired
command! -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function! ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and syntax
" in GUI or color console, enable coloring and search highlighting
if &t_Co > 2 || has("gui_running")
  syntax on
  set background=dark
  set hlsearch
endif

set t_Co=256 " force 256 colors
colorscheme molokai

if has("autocmd")
" Filetypes and indenting settings
  filetype plugin indent on

" For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" |
    \ endif


    " when opening split screen buffer, continue to set relativenumber
    au BufEnter * set relativenumber

    " reload .vimrc automatically upon writing (from stack overflow)
    augroup myvimrc
        au!
        au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
    augroup END

    "auto write every minute
    set updatetime=60000 "in milliseconds
    au! CursorHoldI,CursorHold,BufLeave <buffer> silent! :update 



" autocmds to automatically enter hex mode and handle file writes properly
if has("autocmd")
  " vim -b : edit binary using xxd-format!
  augroup Binary
    au!

    " set binary option for all binary files before reading them
    au BufReadPre *.bin,*.hex setlocal binary

    " if on a fresh read the buffer variable is already set, it's wrong
    au BufReadPost *
          \ if exists('b:editHex') && b:editHex |
          \   let b:editHex = 0 |
          \ endif

    " convert to hex on startup for binary files automatically
    au BufReadPost *
          \ if &binary | Hexmode | endif

    " When the text is freed, the next time the buffer is made active it will
    " re-read the text and thus not match the correct mode, we will need to
    " convert it again if the buffer is again loaded.
    au BufUnload *
          \ if getbufvar(expand("<afile>"), 'editHex') == 1 |
          \   call setbufvar(expand("<afile>"), 'editHex', 0) |
          \ endif

    " before writing a file when editing in hex mode, convert back to non-hex
    au BufWritePre *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd -r" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif

    " after writing a binary file, if we're in hex mode, restore hex mode
    au BufWritePost *
          \ if exists("b:editHex") && b:editHex && &binary |
          \  let oldro=&ro | let &ro=0 |
          \  let oldma=&ma | let &ma=1 |
          \  silent exe "%!xxd" |
          \  exe "set nomod" |
          \  let &ma=oldma | let &ro=oldro |
          \  unlet oldma | unlet oldro |
          \ endif
  augroup END
endif

endif " has("autocmd")

" trailing whitespace and column; must define AFTER colorscheme, setf, etc!
hi ColorColumn ctermbg=black guibg=darkgray
hi WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+\%#\@<!$/

"" LANGUAGE-SPECIFIC OPTIONS
au BufNewFile,BufRead *.tpp set syn=cpp

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Last but not least, allow for local overrides
if filereadable(expand("~/.vimrc.local"))
    source ~/.vim/.vimrc.local
endif

if exists("*Backspace")
    " nothing for now
else
    func Backspace()
    if col('.') == 1
        if line('.')  != 1
        return  "\<ESC>kA\<Del>"
        else
        return ""
        endif
    else
        return "\<Left>\<Del>"
    endif
    endfunc
endif

inoremap <Char-0x7f> <c-r>=Backspace()<CR>
cnoremap <Char-0x7f> <BS>

