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

-- Helper function to check if we're in a uv project
local function is_uv_project()
    local current_dir = vim.fn.getcwd()
    local pyproject_path = current_dir .. "/pyproject.toml"
    local uv_lock_path = current_dir .. "/.uv.lock"

    -- Check if pyproject.toml or .uv.lock exists
    return vim.fn.filereadable(pyproject_path) == 1 or vim.fn.filereadable(uv_lock_path) == 1
end

-- Python runner with uv support and file validation
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

    -- Save file first
    vim.cmd('w')

    -- Determine the command to use
    local command
    if is_uv_project() then
        command = 'uv run ' .. vim.fn.shellescape(current_file)
        vim.notify("Running with uv: " .. current_file, vim.log.levels.INFO)
    else
        command = 'python3 ' .. vim.fn.shellescape(current_file)
        vim.notify("Running with system Python: " .. current_file, vim.log.levels.INFO)
    end

    -- Open terminal and run
    vim.cmd('vnew')
    vim.cmd('terminal ' .. command)
end

-- Alternative function to always use uv run (even outside uv projects)
local function run_python_uv_always()
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

    -- Save and run with uv
    vim.cmd('w')
    vim.cmd('vnew')
    vim.cmd('terminal uv run ' .. vim.fn.shellescape(current_file))
    vim.notify("Running with uv: " .. current_file, vim.log.levels.INFO)
end

-- For normal mode - auto-detect uv project
vim.keymap.set('n', '<F5>', run_python, { noremap = true, silent = true, desc = "Run Python file (auto-detect uv)" })

-- For normal mode - always use uv
vim.keymap.set('n', '<leader><F5>', run_python_uv_always, { noremap = true, silent = true, desc = "Run Python file with uv (always)" })

-- For insert mode - auto-detect
vim.keymap.set('i', '<F5>', function()
    vim.cmd('stopinsert')
    run_python()
end, { noremap = true, silent = true, desc = "Run Python file (auto-detect uv)" })

-- For insert mode - always uv
vim.keymap.set('i', '<leader><F5>', function()
    vim.cmd('stopinsert')
    run_python_uv_always()
end, { noremap = true, silent = true, desc = "Run Python file with uv (always)" })

-- For visual mode - auto-detect
vim.keymap.set('v', '<F5>', function()
    vim.cmd('normal! <Esc>')
    run_python()
end, { noremap = true, silent = true, desc = "Run Python file (auto-detect uv)" })

-- For visual mode - always uv
vim.keymap.set('v', '<leader><F5>', function()
    vim.cmd('normal! <Esc>')
    run_python_uv_always()
end, { noremap = true, silent = true, desc = "Run Python file with uv (always)" })

-- Additional uv-specific keymaps
vim.keymap.set('n', '<leader>ui', ':terminal uv init<CR>', { noremap = true, silent = true, desc = "Initialize uv project" })
vim.keymap.set('n', '<leader>ua', ':terminal uv add ', { noremap = true, desc = "Add package with uv" })
vim.keymap.set('n', '<leader>ur', ':terminal uv remove ', { noremap = true, desc = "Remove packagewith uv" })
vim.keymap.set('n', '<leader>us', ':terminal uv sync<CR>', { noremap = true, silent = true, desc = "Sync uv project" })
vim.keymap.set('n', '<leader>ul', ':terminal uv lock<CR>', { noremap = true, silent = true, desc = "Update uv lock file" })
vim.keymap.set('n', '<leader>uc', ':terminal uv run python<CR>', { noremap = true, silent = true, desc = "Open uv Python REPL" })
