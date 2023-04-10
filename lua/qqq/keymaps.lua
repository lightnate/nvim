-- map leaser to space
vim.g.mapleader = " "

local keyset = vim.keymap.set

-- Save & Quit
keyset("n", "<C-s>", ":w<CR>")
keyset("n", "<C-q>", ":q<CR>")

-- Esc
keyset("i", "<C-;>", "<Esc>")
keyset("v", "<C-;>", "<Esc>")

-- nextline
keyset("i", "<C-j>", "<Esc>o")

-- start & end
keyset("n", "<C-h>", "^")
keyset("n", "<C-l>", "$")
keyset("v", "<C-h>", "^")
keyset("v", "<C-l>", "$")

-- window resize
keyset("n", "<up>", ":resize +5<CR>")
keyset("n", "<down>", ":resize -5<CR>")
keyset("n", "<left>", ":vertical resize -5<CR>")
keyset("n", "<right>", ":vertical resize +5<CR>")

-- buffer
keyset("n", "L", ":bn<CR>")
keyset("n", "H", ":bp<CR>")

-- yank
-- 可视模式下复制完成保存光标在最后的位置
keyset("v", "y", "ygv<Esc>")
keyset("v", "p", '"_dP')

-- search
keyset("n", "*", "*N")

-- move code
-- 普通模式，向下移动一行
keyset("n", "<C-j>", "<Esc>:m .+1<CR><Esc>")
-- 普通模式，向上移动一行
keyset("n", "<C-k>", "<Esc>:m .-2<CR><Esc>")
-- 缩进后保持可视模式
keyset("v", "<", "<gv")
keyset("v", ">", ">gv")
-- 可视行模式，向下移动
keyset("v", "<C-j>", ":m .+2<CR>gv")
-- 可视行模式，向上移动
keyset("v", "<C-k>", ":m .-2<CR>gv")

