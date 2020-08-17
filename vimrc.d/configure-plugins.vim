" ultisnips {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=["~/.vim/bundle/vim-snippets/UltiSnips"]
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsUsePythonVersion = 3
let g:python3_host_prog = system('which python3')
" }}}

" ale {{{
let g:ale_filetype_blacklist = ['qf', 'tags', 'unite', 'terminal', 'term']
let g:ale_sign_column_always = 1
let b:ale_linters = {'python': ['flake8', 'yapf', 'autopep8', 'mypy']}
let b:ale_fixers = ['autopep8', 'yapf']

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" }}}

" vim-airline {{{
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
" let g:airline_section_x = '%{strftime("%H:%M")}'
" }}}

" tagbar {{{
let g:tagbar_autoclose = 0
let g:tagbar_left = 0
let g:tagbar_compact = 1
let g:tagbar_indent = 2
let g:tagbar_show_linenumber = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_sort = 0

" mappings & settins for tagbar
let Tlist_Auto_Highlight_Tag = 1
let Tlist_GainFocus_On_ToggleOpen = 0
let Tlist_Use_Right_Window = 1
" }}}

" tabline.vim {{{
hi TabLine ctermfg=Black ctermbg=Grey cterm=NONE
hi TabLineFill ctermfg=Black ctermbg=Grey cterm=NONE
hi TabLineSel ctermfg=White ctermbg=DarkBlue cterm=NONE
" }}}

" nerdtree {{{
" NerdTree ignoring files
let NERDTreeIgnore = ['\.pyc$']

" To map nerd tree toggle command
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

let g:new_buf_bash = 0
let g:buf_enter_bash = 0
let g:enter_cmd_win = 0


" }}}

" gitgutter {{{
let g:gitgutter_realtime = 1
set updatetime=100
" }}}

" vimwiki {{{
let g:vimwiki_table_mappings = 0

let wiki_1 = {}
let wiki_1.path = '~/vimwiki/'
let wiki_1.path_html = '~/vimwiki_html/'

let wiki_2 = {}
let wiki_2.path = '~/private/'
let wiki_2.path_html = '~/private_html/'

let g:vimwiki_list = [wiki_1, wiki_2]
let g:vimwiki_listsyms = '✗○◐●✓'
" Open wiki on startup
" autocmd VimEnter * VimwikiDiaryIndex"
au BufNewFile ~/vimwiki/diary/*.wiki :silent 0r !~/.vim/bin/vimwiki_diary_template '%'
" }}}

" fzf.vim {{{
set rtp+=/usr/local/bin/fzf
" Floating window for fzf
let $FZF_DEFAULT_OPTS='--layout=reverse --inline-info --margin 0,0,0,1'
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
" }}}

" coc.nvim {{{
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=1

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes
" }}}

" vim-browser {{{
let g:browser = "Brave"

let g:browser_tabs_window_layout = 'floating'
let g:browser_tabs_default_browser = 'Brave'
" }}}

" calendar {{{
let g:calendar_google_calendar=1
let g:calendar_task_delete = 1
" }}}

" vim-registers {{{
let g:vim_registers_window_layout='floating'
" }}}

" vim: fdm=marker
