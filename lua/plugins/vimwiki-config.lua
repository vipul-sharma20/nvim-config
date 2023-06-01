vim.cmd([[
let g:vimwiki_table_mappings = 0

let wiki_1 = {}
let wiki_1.path = '~/tools/noto/'
let wiki_1.path_html = '~/tools/vimwiki_html/'

let wiki_2 = {}
let wiki_2.path = '~/tools/private/'
let wiki_2.path_html = '~/tools/private_html/'

let g:vimwiki_list = [wiki_1, wiki_2]
let g:vimwiki_listsyms = '✗○◐●✓'
" Open wiki on startup
" autocmd VimEnter * VimwikiDiaryIndex"
au BufNewFile ~/tools/noto/diary/*.wiki :silent 0r !~/tools/noto/vimwiki_diary_template '%'

" Kanagawa colors for vimwiki headers
hi VimwikiHeader1 guifg=#FF9E3B " roninYellow
hi VimwikiHeader2 guifg=#DCA561 " autumnYellow
hi VimwikiHeader3 guifg=#957FB8 " oniViolet
hi VimwikiHeader4 guifg=#938AA9 " springViolet
hi VimwikiHeader5 guifg=#9CABCA " sprintViolet2
hi VimwikiHeader6 guifg=#FFFF00
]])

-- Change colors for vimwiki visual selction
vim.api.nvim_set_keymap('v', '<Leader>wc', '<Cmd>VimwikiColorizeNormal<CR>', {noremap = true, silent = true})
