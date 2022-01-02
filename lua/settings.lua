vim.o.ts = 4 -- Insert 4 spaces for a tab
vim.o.sw = 4 -- Change the number of space characters inserted for indentation
vim.o.expandtab = true  -- Converts tabs to spaces

vim.o.pumheight = 25 -- Makes popup menu smaller
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.o.cmdheight = 1 -- Use 2 for more space for displaying messages
vim.o.mouse = "a" -- Enable your mouse
vim.o.timeoutlen = 100 -- By default timeoutlen is 1000 ms
vim.o.undofile = true -- Enable persistent undo
vim.opt.list = true
vim.o.swapfile = false -- Do not write any swp files

-- Colorscheme
vim.cmd('colorscheme kanagawa')
vim.cmd('set bg=dark')
vim.cmd('syntax on') -- syntax highlighting

-- Text folding stuff
vim.o.foldmethod = 'indent'
vim.o.foldnestmax = 10
vim.o.foldenable = false
vim.o.foldlevel = 2
vim.cmd('set indentkeys-=<:>')

vim.cmd('set nu') -- set line numbers
vim.cmd('set laststatus=2')

vim.cmd('set signcolumn=yes') -- Add signcolumn
vim.cmd('set splitright') -- Open splits on the right
vim.cmd('set ignorecase') -- ignore case for search

-- Statusline stuff
vim.cmd([[
    set statusline=%.50F\ -\ FileType:\ %y
    set statusline+=%= " Switch to the right side
    set statusline+=%l " Current line
    set statusline+=/ " Separator
    set statusline+=%L\ " Total lines
    set showtabline=2
]])
