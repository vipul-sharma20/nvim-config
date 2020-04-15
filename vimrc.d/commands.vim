" defaults {{{

" Jsonify
command! Json %!python -m json.tool

" Pretty Print XML
command! XML %!xmllint --format -

"To get the shell command output in a buffer
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>
" }}}

" Greps {{{
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

command! -nargs=+ Fag call fzf#run({
  \ 'source': 'ag "<args>"',
  \ 'sink': function('AgHandler'),
  \ 'options': '+m',
  \ 'tmux_height': '60%'
\ })
" }}}

" Loop color schemes {{{
function! LoopColorScheme()
    let path = split(globpath('~/.vim/bundle/vim-colorschemes/colors/','*'), "\n")
    echo "hh"
    for fl in path
        sleep 500m
        let fl = substitute(fl, "^\/.*\/", "", "g")
        let fl = substitute(fl, ".vim$", "", "g")
        execute ':colorscheme ' . fl . ' | :redraw!'
        execute ':echo ' . fl
        sleep 4000m
    endfor
endfunction
command! -nargs=0 LoopColorScheme call LoopColorScheme()
" }}}

" Toggle tagbar {{{
function! ToggleTagbar()
    if bufwinnr('Tagbar') > 0
        exe bufwinnr('Tagbar') . "windo -" . "exit"
    else
        exe "Tagbar"
    endif
endfunction
command! -nargs=0 ToggleTagbar call ToggleTagbar()
" }}}

" Helping with ctags very simple for now {{{
function! GenCtags()
    !ctags -R
    echo getcwd()
endfunction
command! -nargs=0 GenCtags call GenCtags()
" }}}

" Ctags for Python {{{
function! CtagPython()
    !ctags -R --fields=+l --languages=python --python-kinds=-i -f ./tags $(python3 -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))")
    echo getcwd()
endfunction
command! -nargs=0 CtagPython call CtagPython()
" }}}

" Combine selection {{{
function! s:CombineSelection(line1, line2, cp)
  execute 'let char = "\u'.a:cp.'"'
  execute a:line1.','.a:line2.'s/\%V[^[:cntrl:]]/&'.char.'/ge'
endfunction

" modify selected text using combining diacritics
command! -range -nargs=0 Overline        call s:CombineSelection(<line1>, <line2>, '0305')
command! -range -nargs=0 Underline       call s:CombineSelection(<line1>, <line2>, '0332')
command! -range -nargs=0 DoubleUnderline call s:CombineSelection(<line1>, <line2>, '0333')
command! -range -nargs=0 Strikethrough   call s:CombineSelection(<line1>, <line2>, '0336')
" }}}

" FZF commands {{{
command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})

command! -bang -nargs=* GM call fzf#run({
        \ 'window': 'call CreateCenteredFloatingWindow()',
        \ 'source': GetMatchesFZF(),
        \ 'sink': function('GetScoreFZF'),
        \ 'options': '-x',
        \ 'down': '30%'})
" }}}

" Coc commands {{{
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" }}}

" Coc helper funtions {{{
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" }}}

" vim fzf helper functions {{{
" Jump to tab: <Leader>t
function! TabName(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return fnamemodify(bufname(buflist[winnr - 1]), ':t')
endfunction

" Custom functions
function! s:JumpToTab(line)
    let pair = split(a:line, ' ')
    let cmd = pair[0].'gt'
    execute 'normal' cmd
endfunction

" Ag handler
function! AgHandler(line)
  let parts = split(a:line, ':')
  let [fn, lno] = parts[0 : 1]
  execute 'e '. s:escape(fn)
  execute lno
  normal! zz
endfunction

" floating fzf window with borders
function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])]) - 30
    let height = min([&lines - 4, max([20, &lines - 10])]) - 5
    let top = ((&lines - height) / 2) + 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "❋" . repeat("─", width - 2) . "❋"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "❋" . repeat("─", width - 2) . "❋"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

" Open files with FZF and custom icons (experiment)
function! Fzf_dev()
  let l:fzf_files_options = '--preview "bat --line-range :'.&lines.' --theme="OneHalfDark" --style=numbers,changes --color always {2..-1}"'
  function! s:files()
    let l:files = split(system("fd --type f"), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s  %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m --reverse ' . l:fzf_files_options,
        \ 'down':    '40%',
        \ 'window': 'call CreateCenteredFloatingWindow()'})

endfunction

" Update fzf colors on colorscheme change
function! s:UpdateFZFColors()
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['Comment',      'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['Statement',    'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && code > 0
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
        \ empty(cols) ? '' : (' --color='.join(cols, ','))
endfunction
command! -nargs=0 UpdateFZFColors call UpdateFZFColors()
" }}}

" Other vim helper functions {{{
" Range search
function! RangeSearch(direction)
  call inputsave()
  let g:srchstr = input(a:direction)
  call inputrestore()
  if strlen(g:srchstr) > 0
    let g:srchstr = g:srchstr.
          \ '\%>'.(line("'<")-1).'l'.
          \ '\%<'.(line("'>")+1).'l'
  else
    let g:srchstr = ''
  endif
endfunction
" }}}

" vim: fdm=marker
