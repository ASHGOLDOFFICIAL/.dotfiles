local api = vim.api

api.nvim_command("autocmd TermOpen * startinsert")
api.nvim_command("autocmd TermOpen * setlocal nonumber norelativenumber")
api.nvim_command("autocmd TermEnter * setlocal signcolumn=no")

vim.keymap.set('t', '<esc>', "<C-\\><C-n>")
vim.keymap.set('n', 'tJ', "<C-w>s<C-w>j:term<CR>")
vim.keymap.set('n', 'tL', "<C-w>v<C-w>l:term<CR>")
