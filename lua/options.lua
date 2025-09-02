-- الملف الخاص بالإعدادات

vim.opt.encoding = "utf-8" -- set encoding
vim.opt.nu = true -- enable line numbers
vim.opt.relativenumber = true -- relative line numbers

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.autoindent = true -- auto indentation
vim.opt.smartindent=true
vim.opt.wrap=true


-- Changed from 50 to 4000 (4 seconds) - less aggressive
vim.opt.updatetime=4000
vim.opt.colorcolumn="80"

vim.opt.list = true -- show tab characters and trailing whitespace
vim.opt.formatoptions:remove("t") -- no auto-intent of line breaks, keep line wrap enabled

vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- unless capital letter in search

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- set directory where undo files are stored
vim.opt.undofile = true -- save undo history to a file

vim.opt.hlsearch = false -- do not highlight all matches on previous search pattern
vim.opt.incsearch = true -- incrementally highlight searches as you type

vim.opt.termguicolors = true -- enable true color support

vim.opt.scrolloff = 8 -- minimum number of lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 --minimum number of columns to keep above and below the cursor
vim.opt.signcolumn = "yes" -- always show the sign column, to avoid text shifting when signs are displayed
vim.opt.isfname:append("@-@") -- include '@' in the set of characters considered part of a file name

-- -- Python formatting
-- -- Python-specific indentation settings
-- vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
--   pattern = "*.py",
--   callback = function()
--     vim.opt_local.textwidth = 79
--     vim.opt_local.colorcolumn = "79"
--     -- Better Python indentation
--     vim.opt_local.smartindent = false  -- Disable smartindent for Python
--     vim.opt_local.autoindent = true    -- Keep autoindent
--     vim.opt_local.indentexpr = ""      -- Let filetype plugin handle it
--     -- Python-specific settings
--     vim.b.python_indent_close_paren = false
--     vim.b.python_indent_nested_paren = 4
--     vim.b.python_indent_continue = 4
--   end
-- })
-- Clean trailing whitespace on save
local CleanOnSave = vim.api.nvim_create_augroup('CleanOnSave', {})
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  group = CleanOnSave,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- 10-minute auto-save setup
local AutoSave = vim.api.nvim_create_augroup('AutoSave', {})

-- Track last save time for each buffer
local last_save_times = {}

-- Function to check if 10 minutes have passed since last save
local function should_auto_save(bufnr)
    local current_time = os.time()
    local last_save = last_save_times[bufnr] or 0
    return (current_time - last_save) >= 600 -- 600 seconds = 10 minutes
end

-- Function to perform auto-save
local function auto_save()
    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)

    -- Only save if:
    -- 1. Buffer has a filename
    -- 2. Buffer is modified
    -- 3. Buffer is writable
    -- 4. 10 minutes have passed since last save
    if filename ~= "" and
       vim.api.nvim_buf_get_option(bufnr, 'modified') and
       vim.api.nvim_buf_get_option(bufnr, 'modifiable') and
       not vim.api.nvim_buf_get_option(bufnr, 'readonly') and
       should_auto_save(bufnr) then

        -- Save the file
        vim.cmd('silent! write')

        -- Update last save time
        last_save_times[bufnr] = os.time()

        -- Optional: Show notification (remove if you don't want notifications)
        vim.notify("Auto-saved: " .. vim.fn.fnamemodify(filename, ':t'), vim.log.levels.INFO)
    end
end

-- Only trigger auto-save on specific events (not mode changes)
vim.api.nvim_create_autocmd({"CursorHold"}, {
  group = AutoSave,
  callback = auto_save
})


-- Update last save time when manually saving
vim.api.nvim_create_autocmd({"BufWritePost"}, {
  group = AutoSave,
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    last_save_times[bufnr] = os.time()
  end
})


-- Airline configuration for virtual environment display
vim.g.airline_powerline_fonts = 1 -- Enable powerline fonts (optional)
vim.g['airline#extensions#virtualenv#enabled'] = 1 -- Enable virtualenv extension

-- Custom function to get Python environment info
function _G.get_python_env()
    -- Check for UV project
    local current_dir = vim.fn.getcwd()
    local pyproject_path = current_dir .. "/pyproject.toml"
    local uv_lock_path = current_dir .. "/.uv.lock"

    if vim.fn.filereadable(pyproject_path) == 1 or vim.fn.filereadable(uv_lock_path) == 1 then
        local dir_name = vim.fn.fnamemodify(current_dir, ':t')
        return "🔸uv:" .. dir_name
    end

    -- Check for virtual environment
    local venv = os.getenv("VIRTUAL_ENV")
    if venv then
        local env_name = vim.fn.fnamemodify(venv, ':t')
        return "🐍" .. env_name
    end

    -- Check for conda environment
    local conda_env = os.getenv("CONDA_DEFAULT_ENV")
    if conda_env and conda_env ~= "base" then
        return "🔶conda:" .. conda_env
    end

    return ""
end

-- Configure airline sections to show the environment
-- This adds the environment info to section Y (before file encoding)
vim.g.airline_section_y = '%{v:lua.get_python_env()}'

-- Alternative: Add to section Z (rightmost section)
-- vim.g.airline_section_z = '%{v:lua.get_python_env()} %3p%% %#__accent_bold#%{g:airline_symbols.linenr}%4l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__# %3v'

-- Refresh airline when changing directories
vim.api.nvim_create_autocmd({"DirChanged", "BufEnter"}, {
    callback = function()
        if vim.fn.exists(':AirlineRefresh') == 2 then
            vim.cmd("AirlineRefresh")
        end
    end,
})
