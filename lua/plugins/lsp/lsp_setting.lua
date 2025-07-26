local lspconfig = require("lspconfig")

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

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "lua_ls" },
  automatic_installation = true,
})

-- Python LSP with uv support
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

    lspconfig.pyright.setup({
        on_attach = on_attach,
        settings = settings,
        root_dir = function(fname)
            -- First, try to find uv project markers
            local uv_root = lspconfig.util.root_pattern("pyproject.toml", ".uv.lock")(fname)
            if uv_root then
                return uv_root
            end

            -- Fall back to standard Python project markers
            return lspconfig.util.root_pattern(
                "setup.py",
                "setup.cfg",
                "requirements.txt",
                "Pipfile",
                ".git"
            )(fname) or lspconfig.util.path.dirname(fname)
        end,
    })
end

-- Setup Pyright
setup_pyright()

-- Lua LSP
lspconfig.lua_ls.setup({
  on_attach = on_attach,
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
})

-- Auto-command to refresh LSP when entering a new directory
vim.api.nvim_create_autocmd({"DirChanged"}, {
    callback = function()
        -- Small delay to ensure the directory change is complete
        vim.defer_fn(function()
            -- Restart LSP clients for Python files
            for _, client in pairs(vim.lsp.get_active_clients()) do
                if client.name == "pyright" then
                    vim.cmd("LspRestart pyright")
                    break
                end
            end
        end, 100)
    end,
})

-- Command to manually refresh Python LSP with uv detection
vim.api.nvim_create_user_command('PyRightRefresh', function()
    vim.cmd("LspRestart pyright")
    vim.notify("Restarted Pyright with current directory context", vim.log.levels.INFO)
end, { desc = "Refresh Pyright LSP with uv detection" })
