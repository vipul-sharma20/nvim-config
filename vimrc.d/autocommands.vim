" augroup _fzf
"   autocmd!
"   autocmd ColorScheme * call <sid>UpdateFZFColors()
" augroup END

augroup TerminalStuff
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

" autoreload vimrc
augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

" Go to definition if go file
autocmd FileType go nnoremap<buffer> <Leader>d :GoDef<cr>

" Calendar config
autocmd FileType calendar nmap <buffer> <CR> :<C-u>call vimwiki#diary#calendar_action(b:calendar.day().get_day(), b:calendar.day().get_month(), b:calendar.day().get_year(), b:calendar.day().week(), "V")<CR>

" Coc {{{
" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocAction('doHover')
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" }}}

