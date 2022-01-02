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
]])
