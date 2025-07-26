--  ft = "python" --only work on this file type
--
--  cmd = { "FloatermNew", "FloatermToggle" }, -- Load when these commands are runtime
--
--  keys = { -- Load when these keys are pressed
--              { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
--              { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
--         }
--
-- lazy = true, -- Don't load until explicitly called
--
-- module = "neodev", -- Load when `require("neodev")` is called
--
-- cmd = { "FloatermNew", "FloatermToggle" }, -- Load when these commands are run
--



local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Theme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    -- Treesitter { a way to speed up vim and ad indation
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "cpp", "python" },
                highlight = {
                    enable = true,
                },
            })
        end
    },



    --  Telescope (fuzzy finder)
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },

    --  File tree
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        requires = {
            "nvim-tree/nvim-web-devicons",
        },
        config= function()
            require("nvim-tree").setup {}
        end,
    },

    -- Comments
    {
        'terrortylor/nvim-comment',
        config= function()
            require("nvim_comment").setup({ create_mappings = false })
        end
    },

    --  Multiple- cursors
    {
        "terryma/vim-multiple-cursors",
        lazy = false,  -- Load immediately (since it's a core editing plugin)
        config = function()
            -- Enable default keybindings (Ctrl+n to start)
            vim.g.multi_cursor_use_default_mapping = 1
        end
    },

    --  undo tree
{
    "mbbill/undotree",
    cmd = "UndotreeToggle", -- Load when the command is first used
},


    -- dashbord
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                -- config
            }
        end,
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
    },

    -- airline {the mode file name ..etc bar}
    { 'vim-airline/vim-airline',
},


--lsp
{
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("plugins.lsp.lsp_setting")
    end
},
-- auto complete
{
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
        require("plugins.lsp.cmp_settings")
    end
},



--autoSave and format
{
    "Pocco81/auto-save.nvim",
    config = function()
        require("auto-save").setup {
            enabled = true,
            execution_message = {
                message = function() return "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S") end,
                dim = 0.18,
                cleaning_interval = 1250,
            },
            trigger_events = {"InsertLeave", "TextChanged"},
            write_all_buffers = false,  -- Don't force-write all buffers
            noautocmd = false,          -- Allow undo to work properly
            debounce_delay = 2000,      -- Wait 2s after typing before saving
            condition = function(buf)
                local fn = vim.fn
                local utils = require("auto-save.utils.data")

                return fn.getbufvar(buf, "&modifiable") == 1
                and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) -- يمكنك وضع استثناءات هنا
            end,

            -- هنا نضيف التنسيق قبل الحفظ
            callbacks = {
                before_saving = function()
                    local ok, _ = pcall(function()
                        -- استخدام LSP format إن وجد
                        if vim.lsp.buf.format then
                            vim.lsp.buf.format({ async = false })
                        else
                            vim.cmd("normal! gg=G") -- تنسيق تقليدي
                        end
                    end)
                end,
            },
        }
    end,
},




-- Error Lens - shows diagnostics inline like VS Code
{
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
        require("lsp_lines").setup()
        -- Disable virtual_text since lsp_lines replaces it
        vim.diagnostic.config({
            virtual_text = false,
        })
    end,
},

-- Trouble.nvim for diagnostics panel (xx)
{
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
},


-- Debug Adapter Protocol (DAP)
{
    "mfussenegger/nvim-dap",
    dependencies = {
        -- Optional UI for better debugging experience
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        -- Virtual text support
        "theHamsta/nvim-dap-virtual-text",
        -- Python debugger
        "mfussenegger/nvim-dap-python",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- Setup DAP UI
        dapui.setup()

        -- Setup virtual text
        require("nvim-dap-virtual-text").setup()

        -- Python debugger setup - specify full path to Python
        require("dap-python").setup("python3") -- Try python3 first
        -- Alternative: specify full path if python3 doesn't work
        -- require("dap-python").setup("/usr/bin/python3")
        -- require("dap-python").setup("~/.local/bin/python3")

        -- Auto open/close DAP UI
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- DAP signs/icons
        vim.fn.sign_define('DapBreakpoint', {
            text = '🔴',
            texthl = 'DapBreakpoint',
            linehl = 'DapBreakpoint',
            numhl = 'DapBreakpoint'
        })
        vim.fn.sign_define('DapStopped', {
            text = '▶️',
            texthl = 'DapStopped',
            linehl = 'DapStopped',
            numhl = 'DapStopped'
        })
    end,
},
-- Auto-pairs plugin for better indentation and bracket handling
{
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local autopairs = require("nvim-autopairs")
    local Rule = require("nvim-autopairs.rule")

    autopairs.setup({
      check_ts = true,  -- Enable treesitter
      ts_config = {
        lua = {'string', 'source'},
        javascript = {'string', 'template_string'},
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "vim" },
      fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%)%>%]%)%}%,]]=],
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey='Comment'
      },
    })
    -- Integration with nvim-cmp
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
},

})


