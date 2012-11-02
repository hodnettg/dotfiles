"Not compatible with vi
set nocompatible

" Filetype Stuff
filetype on
filetype plugin on
filetype indent on

"Turn on syntax highlighting
syntax on

"set hidden
set hidden

"Don't update display when executing macros
set lazyredraw

"Let yourself know what mode your'e in
set showmode

"set search scan to wrap around file
set wrapscan

"make command line two lines high 
set ch=2

"keep stuff in history
set history=100

"set tabs to only be 2 spaces
set tabstop=2 shiftwidth=2 expandtab

color tango2

map <C-n> <ESC>:tabnew<RETURN>
map <C-h> <ESC>:tabp<CR>
map <C-l> <ESC>:tabn<CR>
autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror
map <C-d> :execute 'NERDTreeToggle ' . getcwd()<CR>
set guioptions-=T
set ofu=syntaxcomplete#Complete
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

au BufNewFile,BufRead *.ejs set filetype=html
