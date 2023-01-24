vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "GENERAL: Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'GENERAL: Move selected lines up' })
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<CR>', { desc = 'GENERAL: Move line down' })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<CR>', { desc = 'GENERAL: Move line up' })
vim.keymap.set("n", "J", "mzJ`z", { desc = 'Move the line below to the curent line' })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Go half page down and center the window' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Go half page down and center the window' })

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Paste and not lose your buffer' })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = 'Yank to the clipboard that you can use outside vim' })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = 'Yank line to the clipboard that you can use outside vim' })

vim.keymap.set('n', '<leader>d', '"_d', { desc = 'GENERAL: Delete without saving' })
vim.keymap.set('v', '<leader>d', '"_d', { desc = 'GENERAL: Delete without saving' })
vim.keymap.set('n', '<leader>s', '<cmd>w<CR>', { desc = 'GENERAL: Write file' }) -- write file
vim.keymap.set('n', '<leader>S', '<cmd>wa<CR>', { desc = 'GENERAL: Write all files' }) -- write all files

vim.keymap.set('n', '<C-q>', '<C-w>q', { desc = 'GENERAL: Close window' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'GENERAL: Go to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'GENERAL: Go to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'GENERAL: Go to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'GENERAL: Go to right window' })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>fs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/fenrir/packer.lua<CR>");

vim.keymap.set('c', '<C-a>', '<Home>',{ desc = 'GENERAL: Move to the start of the line in command mode' })
vim.keymap.set('c', '<C-e>', '<End>', { desc = 'GENERAL: Move to the end of the line in command mode' })
vim.keymap.set('c', '<C-b>', '<Left>', { desc = 'GENERAL: Move to the left in command mode' })
vim.keymap.set('c', '<C-f>', '<Right>', { desc = 'GENERAL: Move to the right in command mode' })
vim.keymap.set('c', '<M-b>', '<S-Left>', { desc = 'GENERAL: Move one word to the left in command mode' })
vim.keymap.set('c', '<M-f>', '<S-Right>', { desc = 'GENERAL: Move one word to the right in command mode' })
vim.keymap.set('c', '<C-q>', '<C-f>', { desc = 'GENERAL: edit command in command mode' })
