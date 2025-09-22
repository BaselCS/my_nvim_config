-- Updated LSP configuration using vim.lsp.config instead of deprecated lspconfig

-- Helper function to get uv python path
local function get_uv_python_path()
    local handle = io.popen("uv run which python 2>/dev/null")
    if handle then
        local result = handle:read("*a")
        handle:close()
        if result and result ~= "" then
            return result:gsub("%s+", "") -- trim whitespace
        end
    end
    return nil
end

-- Helper function to check if we're in a uv project
local function is_uv_project()
    local current_dir = vim.fn.getcwd()
    local pyproject_path = current_dir .. "/pyproject.toml"
    local uv_lock_path = current_dir .. "/.uv.lock"

    return vim.fn.filereadable(pyproject_path) == 1 or vim.fn.filereadable(uv_lock_path) == 1
end

-- Helper function to find project root
local function find_project_root(fname, patterns)
    local current = fname
    if vim.fn.isdirectory(current) == 0 then
        current = vim.fn.fnamemodify(current, ':h')
    end

    while current ~= '/' do
        for _, pattern in ipairs(patterns) do
            local candidate = current .. '/' .. pattern
            if vim.fn.filereadable(candidate) == 1 or vim.fn.isdirectory(candidate) == 1 then
                return current
            end
        end
        current = vim.fn.fnamemodify(current, ':h')
    end

    return vim.fn.fnamemodify(fname, ':h')
end

local on_attach = function(_, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "pyright", "lua_ls" },
    automatic_installation = true,
})

-- Python LSP with uv support using vim.lsp.config
local function setup_pyright()
    local python_path = nil
    local settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic"
            }
        }
    }

    -- If we're in a uv project, try to get the uv python path
    if is_uv_project() then
        python_path = get_uv_python_path()
        if python_path then
            settings.python.pythonPath = python_path
            vim.notify("Using uv Python: " .. python_path, vim.log.levels.INFO)
        else
            vim.notify("Failed to get uv Python path, falling back to system Python", vim.log.levels.WARN)
        end
    end

    -- Configure Pyright using vim.lsp.config
    vim.lsp.config.pyright = {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml', '.uv.lock', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
        settings = settings,
        on_attach = on_attach,
    }
end

-- Setup Pyright
setup_pyright()

-- Lua LSP using vim.lsp.config
vim.lsp.config.lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false, -- Disable third-party checking
            },
            telemetry = {
                enable = false,
            },
        },
    },
    on_attach = on_attach,
}

-- Auto-command to refresh LSP when entering a new directory
vim.api.nvim_create_autocmd({"DirChanged"}, {
    callback = function()
        -- Small delay to ensure the directory change is complete
        vim.defer_fn(function()
            -- Restart LSP clients for Python files
            for _, client in pairs(vim.lsp.get_clients()) do
                if client.name == "pyright" then
                    client.stop()
                    -- The client will automatically restart when needed
                    break
                end
            end
        end, 100)
    end,
})

-- Command to manually refresh Python LSP with uv detection
vim.api.nvim_create_user_command('PyRightRefresh', function()
    -- Stop and restart Pyright client
    for _, client in pairs(vim.lsp.get_clients()) do
        if client.name == "pyright" then
            client.stop()
            break
        end
    end
    vim.notify("Restarted Pyright with current directory context", vim.log.levels.INFO)
end, { desc = "Refresh Pyright LSP with uv detection" })

-- Enable LSP for current buffer if it matches the filetypes
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    callback = function()
        local filetype = vim.bo.filetype
        if filetype == 'python' then
            vim.lsp.enable('pyright')
        elseif filetype == 'lua' then
            vim.lsp.enable('lua_ls')
        end
    end,
})
