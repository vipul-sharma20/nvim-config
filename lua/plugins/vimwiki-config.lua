vim.g.vimwiki_table_mappings = 0
vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_list = {
    {
        path = vim.fn.expand("~/tools/noto/"),
        path_html = vim.fn.expand("~/tools/vimwiki_html/"),
        syntax = "markdown",
        ext = "md",
    },
    {
        path = vim.fn.expand("~/tools/private/"),
        path_html = vim.fn.expand("~/tools/private_html/"),
    },
}
vim.g.vimwiki_listsyms = "✗○◐●✓"

vim.cmd([[
" Open wiki on startup
" autocmd VimEnter * VimwikiDiaryIndex"
au BufNewFile ~/tools/noto/diary/*.wiki :silent 0r !~/tools/noto/vimwiki_diary_template '%'

" Kanagawa colors for vimwiki headers
" hi VimwikiHeader1 guifg=#FF9E3B " roninYellow
" hi VimwikiHeader2 guifg=#DCA561 " autumnYellow
" hi VimwikiHeader3 guifg=#957FB8 " oniViolet
" hi VimwikiHeader4 guifg=#938AA9 " springViolet
" hi VimwikiHeader5 guifg=#9CABCA " sprintViolet2
" hi VimwikiHeader6 guifg=#FFFF00

autocmd FileType vimwiki setlocal syntax=markdown
]])

-- Change colors for vimwiki visual selction
vim.api.nvim_set_keymap('v', '<Leader>wc', '<Cmd>VimwikiColorizeNormal<CR>', {noremap = true, silent = true})

vim.keymap.set('n', '<C-space>', '<Cmd>VimwikiToggleListItem<CR>', { noremap = true, silent = true })

-- Map 'vimwiki' filetype to use 'markdown' parser
vim.treesitter.language.register('markdown', 'vimwiki')

-- Ensure 'vimwiki' uses Markdown syntax highlighting
vim.api.nvim_create_autocmd("FileType", {
  pattern = "vimwiki",
  callback = function()
    vim.bo.syntax = "markdown"
  end,
})

