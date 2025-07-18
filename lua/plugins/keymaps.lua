-- keymaps for plugins

 -- telescope
vim.keymap.set("n", "<leader>ff", ": Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fp", ": Telescope git_files<cr>")
vim.keymap.set("n", "<leader>fz", ": Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fo", ": Telescope old files<cr>")

--nav tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- nvim-comment
vim.keymap.set({"n", "v"}, "<leader>/", ":CommentToggle<cr>")

-- undo tree
vim.keymap.set("n","<leader>u",vim.cmd.UndotreeToggle)


