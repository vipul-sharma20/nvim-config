" defaults {{{
nnoremap <leader>ss :source ~/vimrc/vimrc<cr>
nnoremap <leader>rc :edit ~/vimrc/vimrc<cr>
nnoremap Y "+y
nnoremap P "+p
inoremap jk <Esc>
" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" }}}

" ale {{{
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>
nnoremap <F8> :ALEFix<CR>
" }}}

" tagbar {{{
nnoremap -L :ToggleTagbar<CR>
" }}}

" nerdtree {{{
nnoremap -B :NERDTreeToggle<CR>
nnoremap -BC :NERDTreeMirror<CR>
" }}}

" FZF {{{
nnoremap <leader>e :FZF<cr>
nnoremap <leader>E :FZF!<cr>
nnoremap <leader>s :BLines<cr>
nnoremap <leader>m :FZFMru<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <Leader>c :Commands<CR>
nnoremap <silent> <leader>f :call Fzf_dev()<CR>
" }}}

" Ag {{{
" nnoremap <leader>f :Ag<cr>
" }}}

" vim-cricket
nnoremap <Leader>gm  :GM<CR>

" vim-browser
nnoremap <Leader>gt :GetBrowserTabs<CR>

" coc.nvim {{{
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)


" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
" }}}

" ROT13
noremap <Leader>r ggg?G

" tig-explorer
noremap <Leader>tig :TigOpenProjectRootDir<CR>

" range search {{{
vnoremap <silent> / :<C-U>call RangeSearch('/')<CR>:if strlen(g:srchstr) > 0\|exec '/'.g:srchstr\|endif<CR>
vnoremap <silent> ? :<C-U>call RangeSearch('?')<CR>:if strlen(g:srchstr) > 0\|exec '?'.g:srchstr\|endif<CR>
" }}}


" vim: fdm=marker
