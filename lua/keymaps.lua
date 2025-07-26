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

-- end of file with zz
vim.keymap.set("n","G","Gzz")


--search with center foucs
vim.keymap.set("n","n","nzzzv")
vim.keymap.set("n","N","nzzzv")


--fast saving
vim.keymap.set("n", "<leader>w", ":w<CR>")

--close file
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- add new line by enter in normll mode
vim.keymap.set("n","<Enter>","o<Esc>")


-- Python runner with file validation
local function run_python()
    local current_file = vim.fn.expand('%')
    local file_type = vim.bo.filetype

    -- Check if we have a valid file and it's a Python file
    if current_file == '' then
        vim.notify("No file is currently open", vim.log.levels.WARN)
        return
    end

    if file_type ~= 'python' then
        vim.notify("Current file is not a Python file", vim.log.levels.WARN)
        return
    end

    -- Check if file exists on disk
    if vim.fn.filereadable(current_file) == 0 then
        vim.notify("File doesn't exist on disk. Save it first.", vim.log.levels.WARN)
        return
    end

    -- Save and run
    vim.cmd('w')
    vim.cmd('vnew')
    vim.cmd('terminal python3 ' .. vim.fn.shellescape(current_file))
end

-- For normal mode
vim.keymap.set('n', '<F5>', run_python, { noremap = true, silent = true, desc = "Run Python file" })

-- For insert mode
vim.keymap.set('i', '<F5>', function()
    vim.cmd('stopinsert')
    run_python()
end, { noremap = true, silent = true, desc = "Run Python file" })

-- For visual mode
vim.keymap.set('v', '<F5>', function()
    vim.cmd('normal! <Esc>')
    run_python()
end, { noremap = true, silent = true, desc = "Run Python file" })
