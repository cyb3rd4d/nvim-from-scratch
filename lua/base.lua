local opt = vim.opt
local keymap = vim.keymap

vim.g.mapleader = " "

opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true

-- Window navigation in insert mode
keymap.set("i", "<C-h>", "<Left>", {})
keymap.set("i", "<C-j>", "<Down>", {})
keymap.set("i", "<C-k>", "<Up>", {})
keymap.set("i", "<C-l>", "<Right>", {})

-- Window navigation in normal mode
keymap.set("n", "<C-h>", "<C-w>h", {})
keymap.set("n", "<C-j>", "<C-w>j", {})
keymap.set("n", "<C-k>", "<C-w>k", {})
keymap.set("n", "<C-l>", "<C-w>l", {})
