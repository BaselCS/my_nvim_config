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




-- REPL Management (j==Jupyter-like)
vim.keymap.set('n', '<leader>js', '<cmd>IronRepl<cr>', { desc = "Start REPL" })
vim.keymap.set('n', '<leader>jr', '<cmd>IronRestart<cr>', { desc = "Restart REPL" })
vim.keymap.set('n', '<leader>jh', '<cmd>IronHide<cr>', { desc = "Hide REPL window" })

vim.keymap.set('n', '<leader>jc', '<cmd>lua require("iron.core").send_motion()<cr>', { desc = "Send motion to REPL" })
vim.keymap.set('v', '<leader>jc', '<cmd>lua require("iron.core").visual_send()<cr>', { desc = "Send selection to REPL" })
vim.keymap.set('n', '<leader>jl', '<cmd>lua require("iron.core").send_line()<cr>', { desc = "Send line to REPL" })
vim.keymap.set('n', '<leader>jf', '<cmd>lua require("iron.core").send_file()<cr>', { desc = "Send file to REPL" })
vim.keymap.set("n", "<leader>jd", '<cmd>lua require("iron.core").send("python", "%clear")<cr>', { desc = "delete REPL output" })


-- Search for cell then run it
local function search_and_run_cell()
  -- Search for cell marker
  vim.fn.search("# %%", "b")  -- Search backwards for cell start
  -- Move to next line (actual cell content)
  vim.cmd("normal! j")
  -- Select until next cell or end of file
  vim.cmd("normal! V")
  -- Search forward for next cell or go to end
  local next_cell = vim.fn.search("# %%", "n")
  if next_cell > 0 then
    vim.fn.search("# %%")
    vim.cmd("normal! k")  -- Go to line before next cell marker
  else
    vim.cmd("normal! G")  -- Go to end of file
  end
  -- Send selection to REPL
  require("iron.core").visual_send()
  -- Clear selection
end

vim.keymap.set('n', '<leader>jb', search_and_run_cell, { desc = "Search and run current cell" })

-- Keymap to clear IPython REPL
vim.keymap.set('n', '<leader>jc', function()
  require("iron.core").send(nil, {"clear"})
end, { desc = "Clear IPython REPL" })

local function insert_ipython_cell()
  local line = vim.api.nvim_get_current_line()
  vim.api.nvim_put({ line .. "# %%" }, "l", true, true)
end
vim.keymap.set("n", "<leader>C", insert_ipython_cell, { desc = "Insert IPython cell marker (# %%)" })
