let maplocalleader = ','

" Make YCM not load by default.
" This is done by simply telling it that it's already loaded.
let g:loaded_youcompleteme = 1

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" Languages
Bundle 'tpope/vim-markdown'
Bundle 'digitaltoad/vim-jade'
Bundle 'jimenezrick/vimerl'
Bundle 'vim-scripts/django.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'lukerandall/haskellmode-vim'
Bundle 'vim-scripts/indenthaskell.vim'
Bundle 'xuhdev/vim-latex-live-preview'
Bundle 'groenewege/vim-less'
Bundle 'tclem/vim-arduino'
Bundle 'dag/vim-fish'

" Code Completion
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'

" Snippets
Bundle 'SirVer/ultisnips'

" Airline
Bundle 'bling/vim-airline'
Bundle 'edkolev/tmuxline.vim'

" Misc.
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-commentary'
Bundle 'bkad/CamelCaseMotion'
Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-session'
Bundle 'nacitar/terminalkeys.vim'
Bundle 'danro/rename.vim'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'pbrisbin/html-template-syntax'
" Bundle 'vim-scripts/Haskell-Conceal'


filetype plugin indent on     " required!

"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed.


"""""""""""""""""""""""""""""""
"""""""" Configuration """"""""
"""""""""""""""""""""""""""""""

"""" Erlang Configuration """"

" This locks up vim after saving. Get rid of it.
let erlang_show_errors = 0


"""" Haskell Configuration """"

let g:haddock_browser = '/usr/bin/firefox'

au BufEnter *.hs compiler ghc
au BufNewFile,BufRead *.tpl set filetype=html


"""" LaTeX Configuration """"

let g:livepreview_previewer = 'evince'


"""" Arduino Configuration """"

let g:vim_arduino_library_path = '/usr/share/arduino'
let g:vim_arduino_serial_port = '/dev/ttyUSB0'


""" Swapfiles """

" Put swapfiles in ~/.vim/tmp/
" This fixes things like docpad, which watch for file changes.
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set undodir=~/.vim/tmp/undo//


""" Column Margin """
set colorcolumn=80


"""" Mappings """"
nnoremap ; :
vnoremap ; :

nnoremap Z zM


"""" Airline Configuration """"

set laststatus=2
set showtabline=2

let g:airline_theme="light"
let g:airline#extensions#tabline#enabled = 1

let g:tmuxline_preset="tmux"

" Symbols
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" Trailing whitespace is bad.
" set list listchars=trail:.
" highlight SpecialKey ctermfg=Red ctermbg=Red


" Airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''


" Automatically reload the .vimrc file.
"augroup myvimrc
"    au!
"    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC
"" | if has('gui_running') | so $MYGVIMRC | endif
"augroup END

syntax enable
set background=light



""""""""""""""""""""""""""""""""""""""
"""""" Custom keys and commands """"""
""""""""""""""""""""""""""""""""""""""

" Make :Q do the same thing as :q.
command! Q q


" Make Up/Down/Home/End keys behave graphically.

function! NoremapNormalCmd(key, preserve_omni, ...)
	let cmd = ''
	let icmd = ''
	for x in a:000
		let cmd .= x
		let icmd .= "<C-\\><C-O>" . x
	endfor
	execute ":nnoremap <silent> " . a:key . " " . cmd
	execute ":vnoremap <silent> " . a:key . " " . cmd
	if a:preserve_omni
		execute ":inoremap <silent> <expr> " . a:key . " pumvisible() ? \"" . a:key . "\" : \"" . icmd . "\""
	else
		execute ":inoremap <silent> " . a:key . " " . icmd
	endif
endfunction

" Cursor moves by screen lines
call NoremapNormalCmd("<Up>", 1, "gk")
call NoremapNormalCmd("<Down>", 1, "gj")
call NoremapNormalCmd("<Home>", 0, "g<Home>")
call NoremapNormalCmd("<End>", 0, "g<End>")

" PageUp/PageDown preserve relative cursor position
call NoremapNormalCmd("<PageUp>", 0, "<C-U>", "<C-U>")
call NoremapNormalCmd("<PageDown>", 0, "<C-D>", "<C-D>")


" nnoremap <Up> gk
" nnoremap <Down> gj
" nnoremap <Home> g<Home>
" nnoremap <End> g<End>
" 
" vnoremap <Up> gk
" vnoremap <Down> gj
" vnoremap <Home> g<Home>
" vnoremap <End> g<End>
" 
" inoremap <Up> <C-o>gk
" inoremap <Down> <C-o>gj
" inoremap <Home> <C-o>g<Home>
" inoremap <End> <C-o>g<End>

" Omnicomplete with <C-Space>
inoremap <C-@> <C-x><C-o>
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"set completeopt=longest,menuone
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"	\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"
"inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"	\ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"
"" open omni completion menu closing previous if open and opening new menu without changing the text
"inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
"	\ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
"" open user completion menu closing previous if open and opening new menu without changing the text
"inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
"	\ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'


"""""""""""""""""""""""""""""
"""""" Editor behavior """"""
"""""""""""""""""""""""""""""

" Tab completion
set wildmenu
set wildmode=longest:full,full

" Session stuff
let g:session_autoload="no"
let g:session_autosave="yes"
command! -nargs=1 S OpenSession <args>

" Line numbering
set nonumber
set relativenumber
function! NumberToggle()
	if (&relativenumber == 1)
		set number
		set norelativenumber
	else
		set nonumber
		set relativenumber
	endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>


" Allows the cursor to be positioned one character past the end of the line in command mode.
set virtualedit=onemore

" Don't save options or folds with sessions.
set ssop-=options
set ssop-=folds

" Set tab stops to 4 spaces. 8 is far too many.
set shiftwidth=4
set tabstop=4

" Ctags
set tags=./tags;


" Tab switching
map <C-PageUp> ;tabp<CR>
map <C-PageDown> ;tabn<CR>

" imap <Up> <NOP>
" imap <Down> <NOP>
" imap <Left> <NOP>
" imap <Right> <NOP>

" nmap <Up> <NOP>
" nmap <Down> <NOP>
" nmap <Left> <NOP>
" nmap <Right> <NOP>

" Coloring
" if &term =~ '256color'
"   " Disable Background Color Erase (BCE) so that color schemes
"   " render properly when inside 256-color tmux and GNU screen.
"   " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
"   set t_ut=
" endif


" Tab Numbers
set showtabline=2
set tabline=%!MyTabLine()
function! MyTabLine()
  let s = '' " complete tabline goes here
  " loop through each tab page
  for t in range(tabpagenr('$'))
    " select the highlighting for the buffer names
    if t + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    " empty space
    let s .= ' '
    " set the tab page number (for mouse clicks)
    let s .= '%' . (t + 1) . 'T'
    " set page number string
    let s .= t + 1 . ' '
    " get buffer names and statuses
    let n = ''  "temp string for buffer names while we loop and check buftype
    let m = 0 " &modified counter
    let bc = len(tabpagebuflist(t + 1))  "counter to avoid last ' '
    " loop through each buffer in a tab
    for b in tabpagebuflist(t + 1)
      " buffer types: quickfix gets a [Q], help gets [H]{base fname}
      " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
      if getbufvar( b, "&buftype" ) == 'help'
        let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
      elseif getbufvar( b, "&buftype" ) == 'quickfix'
        let n .= '[Q]'
      else
        let n .= pathshorten(bufname(b))
        "let n .= bufname(b)
      endif
      " check and ++ tab's &modified count
      if getbufvar( b, "&modified" )
        let m += 1
      endif
      " no final ' ' added...formatting looks better done later
      if bc > 1
        let n .= ' '
      endif
      let bc -= 1
    endfor
    " add modified label [n+] where n pages in tab are modified
    if m > 0
      "let s .= '[' . m . '+]'
      let s.= '+ '
    endif
    " add buffer names
    if n == ''
      let s .= '[No Name]'
    else
      let s .= n
    endif
    " switch to no underlining and add final space to buffer list
    "let s .= '%#TabLineSel#' . ' '
    let s .= ' '
  endfor
  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'
  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999XX'
  endif
  return s
endfunction

