" Tab specific options
set tabstop=8                   "A tab is 8 spaces
set expandtab                   "Always uses spaces instead of tabs
set softtabstop=4               "Insert 4 spaces when tab is pressed
set shiftwidth=4                "An indent is 4 spaces
set smarttab                    "Indent instead of tab at start of line
set shiftround                  "Round spaces to nearest shiftwidth multiple
set nojoinspaces                "Don't convert spaces to tabs

" function! Snippet(name)
" 	exec "r".a:name
" endfunction
" 
" nnoremap + :call Snippet('~/.vim/snippets/haskell/separator')<CR>
" 
" nnoremap <m-=> :call Snippet('~/.vim/snippets/haskell/bigsep')<CR>

set foldmarker={{{,}}}
set foldmethod=marker

