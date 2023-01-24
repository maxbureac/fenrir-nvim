vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move one line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move one line up' })

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

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = 'Delete to the void register' })
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save file" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/fenrir/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
