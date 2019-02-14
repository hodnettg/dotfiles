call plug#begin()

" NerdTree (remapped keys below)
Plug 'scrooloose/nerdtree'

" Easy Commenting with gc
Plug 'tpope/vim-commentary'

" Async Linting
" Plug 'neomake/neomake'

" Better Markdown/Writing Support
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-litecorrect'
Plug 'reedes/vim-lexical'
Plug 'junegunn/goyo.vim'
Plug 'dkarter/bullets.vim'

" Syntax highlighting
" Disabling Vim-Polyglot for now as it makes markdown
" files slower to open even when disabled
" Plug 'sheerun/vim-polyglot'

" Color Schemes
Plug 'ajh17/spacegray.vim'
Plug 'junegunn/seoul256.vim'

" Ruby Automatic End Insertion
Plug 'tpope/vim-endwise'

call plug#end()

" General config for colorscheme etc.
syntax on
filetype plugin indent on
set nocp
set t_Co=256
color tango2

" Set leader as ;, loses some functionality for next f or t commands
let mapleader=";"

" Tabs and spacing
set autoindent
set cindent
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab

" set nu " Display Line Numbers
" set ruler " Shows the Ruler for the cursor, can be slower
set wildmenu " Allow status line to show possible completion of commands etc.
set backspace=indent,eol,start " Allow use of backspace key to move backwards
set nohlsearch " Don't highlight searches
set history=100 " Keep more in history
set lazyredraw " Don't update display when executing macros
" set mouse=a " Enable use of mouse to click/select/move-to-text

" Copy to clipboard with leader, y
" Doesn't work on Vagrant
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard with leader, p
" Doesn't work on Vagrant
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" treat ejs files like HTML files
au BufNewFile,BufRead *.ejs set filetype=html

" Syntax highlighting in Markdown
" au BufNewFile,BufReadPost *.md set filetype=markdown
" let g:polyglot_disabled = ['markdown']
let g:markdown_fenced_languages = ['bash=sh', 'css', 'django', 'javascript', 'js=javascript', 'json=javascript', 'perl', 'php', 'python', 'ruby', 'sass', 'xml', 'html', 'vim']

" Neomake config
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
" call neomake#configure#automake('nrwi', 500)

" Setup Prose mode for markdown and text files
function! Prose()
  " better color
  colorscheme seoul256

  " Enter Goyo mode
  Goyo 80

  " Set up wrap and spell check plugins
  call pencil#init()
  call litecorrect#init()
  call lexical#init()

  " replace common punctuation
  iabbrev <buffer> -- –
  iabbrev <buffer> --- —
endfunction

autocmd FileType markdown,md,mkd,text call Prose()

" text wrapping for commits and spell check
autocmd Filetype gitcommit setlocal spell textwidth=72

"setup Marked 2 Preview with <leader>p in markdown files
function! s:setupMarkup()
  nnoremap <leader>p :silent !open -a "Marked 2.app" '%:p'<cr>:redr!<CR>
endfunction
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" Setup Nerdtree Shortcuts
map <C-n> <ESC>:tabnew<RETURN>
map <C-h> <ESC>:tabp<CR>
map <C-l> <ESC>:tabn<CR>
map <C-d> :execute 'NERDTreeToggle ' . getcwd()<CR>

" Highlight Trailing Whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

" Highlight Lines over 100 characters
highlight LineLengthError ctermbg=black guibg=black
autocmd ColorScheme * highlight LineLengthError ctermbg=black guibg=black
autocmd BufRead,InsertEnter,InsertLeave * 2match LineLengthError /\%100v.*/

" F5 Command to clean up all trailing whitespace
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
