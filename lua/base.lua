vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.g.mapleader = " "

vim.keymap.set("i", "<C-h>", "<Left>", {})
vim.keymap.set("i", "<C-j>", "<Down>", {})
vim.keymap.set("i", "<C-k>", "<Up>", {})
vim.keymap.set("i", "<C-l>", "<Right>", {})

vim.keymap.set("n", "<C-h>", "<C-w>h", {})
vim.keymap.set("n", "<C-j>", "<C-w>j", {})
vim.keymap.set("n", "<C-k>", "<C-w>k", {})
vim.keymap.set("n", "<C-l>", "<C-w>l", {})
