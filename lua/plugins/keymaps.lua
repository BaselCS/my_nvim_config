-- keymaps for plugins

 -- telescope
vim.keymap.set("n", "<leader>ff", ": Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fp", ": Telescope git_files<cr>")
vim.keymap.set("n", "<leader>F", ": Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>gd", ": Telescope lsp_definitions<cr>")


--nav tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- nvim-comment
vim.keymap.set({"n", "v"}, "<leader>/", ":CommentToggle<cr>")

-- undo tree
-- vim.keymap.set("n","<leader>u",vim.cmd.UndotreeToggle)
vim.keymap.set("n","<leader>u", ":UndotreeToggle<cr>")

-- error debugging LSP Lines toggle
vim.keymap.set("n", "<leader>l", require("lsp_lines").toggle,
  { desc = "Toggle lsp_lines" })

-- Error debugging Trouble.nvim keybindings
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",
  { desc = "Diagnostics (Trouble)" })

vim.keymap.set("n", "<leader>xt", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "Buffer Diagnostics (Trouble)" })

vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",
  { desc = "Symbols (Trouble)" })

vim.keymap.set("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { desc = "LSP Definitions / references / ... (Trouble)" })

vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>",
  { desc = "Location List (Trouble)" })

vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",
  { desc = "Quickfix List (Trouble)" })




-- DAP (Debug Adapter Protocol) keybindings
vim.keymap.set("n", "<leader>d", "<cmd>DapToggleBreakpoint<cr>",
  { desc = "Toggle Breakpoint" })

vim.keymap.set("n", "<leader><F1>", "<cmd>DapContinue<cr>",
  { desc = "Continue" })

vim.keymap.set("n", "<leader><F2>", "<cmd>DapStepInto<cr>",
  { desc = "Step Into" })

vim.keymap.set("n", "<leader><F3>", "<cmd>DapStepOver<cr>",
  { desc = "Step Over" })

vim.keymap.set("n", "<leader><F4>", "<cmd>DapStepOut<cr>",
  { desc = "Step Out" })

vim.keymap.set("n", "<leader><F6>", "<cmd>DapRestart<cr>",
  { desc = "Restart" })

vim.keymap.set("n", "<leader><F7>", "<cmd>DapShowLog<cr>",
  { desc = "Show Log" })

vim.keymap.set("n", "<leader><F8>", "<cmd>DapTerminate<cr>",
  { desc = "Terminate" })

vim.keymap.set("n", "<leader><F9>", "<cmd>lua require('dapui').toggle()<cr>",
  { desc = "Toggle Debug UI" })

vim.keymap.set("n", "<leader><F10>", "<cmd>lua require('dapui').eval()<cr>",
  { desc = "Eval" })

-- Python specific debugging
vim.keymap.set("n", "<leader><F11>", "<cmd>lua require('dap-python').test_method()<cr>",
  { desc = "Test Method" })

vim.keymap.set("n", "<leader><F12>", "<cmd>lua require('dap-python').test_class()<cr>",
  { desc = "Test Class" })


-- Copilot
-- Toggle Copilot
vim.keymap.set("n", "<leader>ai", ":Copilot toggle<CR>", { desc = "Toggle Copilot" })
vim.keymap.set("n", "<leader>aie", ":Copilot enable<CR>", { desc = "Enable Copilot" })
vim.keymap.set("n", "<leader>aid", ":Copilot disable<CR>", { desc = "Disable Copilot" })

-- Suggestion Navigation (in Insert Mode)
vim.keymap.set("i", "<C-l>", 'copilot#Accept("<CR>")', {
  expr = true,
  silent = true,
  desc = "Accept Copilot Suggestion"
})
vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)")







