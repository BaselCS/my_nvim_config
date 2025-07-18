-- keymaps for vim
vim.g.mapleader = " "
-- stop Space from working in n and v
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })

-- Paste in visual mode without yanking replaced text
vim.keymap.set("x", "p", [["_dP]])

-- yank to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete without yanking
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- move the line
vim.keymap.set("v","J",":m '>+1<CR>gv=gv")
vim.keymap.set("v","K",":m '<-2<CR>gv=gv")

--move half but with zz
vim.keymap.set("n","<C-d>","<C-d>zz")
vim.keymap.set("n","<C-u>","<C-u>zz")


--search with center foucs
vim.keymap.set("n","n","nzzzv")
vim.keymap.set("n","N","nzzzv")

--fast saving
vim.keymap.set("n", "<leader>w", ":w<CR>")

--close file
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- add new line by enter in normll mode
vim.keymap.set("n","<Enter>","o<Esc>")



-- run python code by F5
vim.api.nvim_set_keymap('n', '<F5>', ':w<CR>:!python3 %<CR>', { noremap = true, silent = true })



