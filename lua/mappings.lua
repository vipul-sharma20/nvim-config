local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Key mapping to go to normal mode in terminal mode
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

