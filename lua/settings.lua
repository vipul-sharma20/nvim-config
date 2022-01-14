-- Tabs and spaces
vim.o.ts = 4 -- Insert 4 spaces for a tab
vim.o.sw = 4 -- Change the number of space characters inserted for indentation
vim.o.expandtab = true  -- Converts tabs to spaces

-- Colorscheme
vim.cmd('colorscheme kanagawa')
vim.o.bg = "dark"
vim.o.syntax = "on"

-- Text folding stuff
vim.o.foldmethod = "indent"
vim.o.foldnestmax = 10
vim.o.foldenable = false
vim.o.foldlevel = 2
vim.cmd('set indentkeys-=<:>')

-- Statusline stuff
vim.cmd([[
    set statusline=%.50F\ -\ FileType:\ %y
    set statusline+=%= " Switch to the right side
    set statusline+=%l " Current line
    set statusline+=/ " Separator
    set statusline+=%L\ " Total lines
    set showtabline=2
]])

-- Misc
vim.o.pumheight = 25 -- Makes popup menu smaller
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.o.cmdheight = 1 -- Use 2 for more space for displaying messages
vim.o.mouse = "a" -- Enable your mouse
vim.o.timeoutlen = 100 -- By default timeoutlen is 1000 ms
vim.o.undofile = true -- Enable persistent undo
vim.o.list = true
vim.o.swapfile = false -- Do not write any swp files
vim.o.nu = true -- Show line numbers
vim.o.laststatus = 2 -- Show statusline
vim.o.ignorecase = true -- Ignore case when searching
vim.o.signcolumn = "yes" -- Show signs column left of line numbers
vim.o.splitright = true -- Create a new split on the right

