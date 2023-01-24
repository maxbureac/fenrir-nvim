local builtin = require('telescope.builtin')
require('telescope').load_extension('fzf')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {desc = "Search project files"})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {desc = "Search recent buffers"})
vim.keymap.set('n', '<leader>pk', builtin.keymaps, {desc = "Search keymap"})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ")})
end, {desc = "Search project symbol"})
vim.keymap.set('n', '<C-p>', builtin.git_files, {desc = "Search project git files"})
