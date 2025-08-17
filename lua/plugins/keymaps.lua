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

vim.keymap.set("n", "<F1>", "<cmd>DapContinue<cr>",
  { desc = "Continue" })

vim.keymap.set("n", "<F2>", "<cmd>DapStepInto<cr>",
  { desc = "Step Into" })

vim.keymap.set("n", "<F3>", "<cmd>DapStepOver<cr>",
  { desc = "Step Over" })

vim.keymap.set("n", "<F4>", "<cmd>DapStepOut<cr>",
  { desc = "Step Out" })

vim.keymap.set("n", "<F6>", "<cmd>DapRestart<cr>",
  { desc = "Restart" })

vim.keymap.set("n", "<F7>", "<cmd>DapShowLog<cr>",
  { desc = "Show Log" })

vim.keymap.set("n", "<F8>", "<cmd>DapTerminate<cr>",
  { desc = "Terminate" })

vim.keymap.set("n", "<F9>", "<cmd>lua require('dapui').toggle()<cr>",
  { desc = "Toggle Debug UI" })

vim.keymap.set("n", "<F10>", "<cmd>lua require('dapui').eval()<cr>",
  { desc = "Eval" })

-- Python specific debugging
vim.keymap.set("n", "<F11>", "<cmd>lua require('dap-python').test_method()<cr>",
  { desc = "Test Method" })

vim.keymap.set("n", "<F12>", "<cmd>lua require('dap-python').test_class()<cr>",
  { desc = "Test Class" })


-- Copilot
vim.keymap.set("n", "<leader>ce", ":Copilot enable<cr>")
vim.keymap.set("n", "<leader>cd", ":Copilot disable<cr>")
vim.keymap.set("n", "<leader>cl", ":Copilot log<cr>")


-- Suggestion Navigation (in Insert Mode)
vim.keymap.set("i", "<C-l>", 'copilot#Accept("<cr>")', {
  expr = true,
  silent = true,
  desc = "Accept Copilot Suggestion"
})
vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)")




-- REPL Management
vim.keymap.set('n', '<leader>rs', '<cmd>IronRepl<cr>', { desc = "Start REPL" })
vim.keymap.set('n', '<leader>rr', '<cmd>IronRestart<cr>', { desc = "Restart REPL" })
vim.keymap.set('n', '<leader>rf', '<cmd>IronFocus<cr>', { desc = "Focus REPL window" })
vim.keymap.set('n', '<leader>rh', '<cmd>IronHide<cr>', { desc = "Hide REPL window" })

-- Send code to REPL (like Jupyter cells)
vim.keymap.set('n', '<leader>sc', '<cmd>lua require("iron.core").send_motion()<cr>', { desc = "Send motion to REPL" })
vim.keymap.set('v', '<leader>sc', '<cmd>lua require("iron.core").visual_send()<cr>', { desc = "Send selection to REPL" })
vim.keymap.set('n', '<leader>sl', '<cmd>lua require("iron.core").send_line()<cr>', { desc = "Send line to REPL" })
vim.keymap.set('n', '<leader>sf', '<cmd>lua require("iron.core").send_file()<cr>', { desc = "Send file to REPL" })

-- Jupyter-like cell execution (send paragraph/function)
vim.keymap.set('n', '<leader>sp', 'vip<leader>sc', { desc = "Send paragraph to REPL", remap = true })
vim.keymap.set('n', '<leader>sb', 'v}k<leader>sc', { desc = "Send block to REPL", remap = true })

-- REPL control
vim.keymap.set('n', '<leader>s<cr>', '<cmd>lua require("iron.core").send_mark()<cr>', { desc = "Send mark to REPL" })
vim.keymap.set('n', '<leader>s<space>', '<cmd>lua require("iron.core").send_interrupt()<cr>', { desc = "Interrupt REPL" })
vim.keymap.set('n', '<leader>sq', '<cmd>lua require("iron.core").close_repl()<cr>', { desc = "Quit REPL" })
vim.keymap.set('n', '<leader>cl', '<cmd>lua require("iron.core").send_mark()<cr>', { desc = "Clear REPL" })

-- Quick send common commands
vim.keymap.set('n', '<leader>si', function()
    require("iron.core").send(nil, {"import numpy as np", "import pandas as pd", "import matplotlib.pyplot as plt"})
end, { desc = "Send common imports" })

vim.keymap.set('n', '<leader>sm', function()
    require("iron.core").send(nil, {"%matplotlib inline"})
end, { desc = "Enable matplotlib inline" })
