set ignorecase
set wildmenu
set pastetoggle=<F5>
set number
set norelativenumber
set smartindent
set bg=dark
set mouse=a
set wildignorecase
set encoding=UTF-8

" Enable folding
set foldmethod=indent

" Do not set, as it slows vim down
set nocursorline

" to make vim show current filename
set laststatus=2

" to enable auto sysntax highlighting by enabling auto detection of file type
filetype on

"to autoindent the next line
set autoindent

" to make the backspace key work
set backspace=indent,eol,start

" this line makes vim search for tag folder recursively till the /
set tags=./tags;/,tags;/

" Don't remove the trailing whitespace
set fillchars=fold:\ 

" settings for the indentLine and indentGuide plugins
set ts=4 sw=4 et

" mappings & settings for split-term plugin
set splitright
set splitbelow

colorscheme onedark

" Abbreviations
ab ishrug ¯\_(ツ)_/¯

highlight clear SignColumn
highlight clear Folded
highlight CustomHighlightGroup ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow

" highlight ColorColumn ctermbg=magenta
" call matchadd('ColorColumn', '\%81v', 100)

" disable command display in statusline
set noshowcmd

" Set terminal color
set termguicolors

" Don't load matchit.vim (paren/bracket matching)
let loaded_matchparen=1

" Don't match parentheses/brackets
set noshowmatch

" Wait to redraw
set lazyredraw

" Scroll 8 lines at a time at bottom/top
" set scrolljump=8

" Highlight bad whitespace
highlight ws ctermbg=yellow guibg=yellow

match ws /\s\+$/
autocmd BufWinEnter * match ws / \+$/

match CustomHighlightGroup /TODO\|FIXME/

" syntax on
filetype plugin indent on

" Settings to make netrw more usable
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 15
let g:netrw_preview = 1

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

