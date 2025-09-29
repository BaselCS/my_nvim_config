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
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000, -- Make sure to load this before all other plugins
        config = function()
            vim.cmd.colorscheme("gruvbox")
            -- Optional gruvbox configuration
            require("gruvbox").setup({
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = true,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "hard", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })
        end,
    },
    -- Treesitter { a way to speed up vim and add indation
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "markdown", "markdown_inline",},
                highlight = {
                    enable = true,
                },
            })
        end
    },

    --  Telescope (fuzzy finder)
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim' ,
            -- make tele fater
            {'nvim-telescope/telescope-fzf-native.nvim',build='make'}
        },
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
    { 'vim-airline/vim-airline'},

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

    -- github copilot
    {
        "github/copilot.vim",
    },


-- Auto-pairs plugin for better indentation and bracket handling
{
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
      check_ts = true,  -- Enable treesitter
      ts_config = {
        lua = {'string', 'source'},
        javascript = {'string', 'template_string'},
        python = {'string', 'comment'},  -- Enhanced Python support
        java = false,
      },
      disable_filetype = { "TelescopePrompt", "vim" },
      disable_in_macro = true,  -- Disable in macros
      disable_in_visualblock = false,
      disable_in_replace_mode = true,
      ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
      enable_moveright = true,
      enable_afterquote = true,
      enable_check_bracket_line = false,  -- Don't check bracket on same line
      enable_bracket_in_quote = true,
      enable_abbr = false,
      break_undo = true,
      map_cr = true,
      map_bs = true,
      map_c_h = false,
      map_c_w = false,
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



-- Iron.nvim for Jupyter notebook REPL
{
    "Vigemus/iron.nvim",
    ft = "python", -- Only load for Python files
    config = function()

        local iron = require("iron.core")

        iron.setup {
            config = {
                scratch_repl = true,
                repl_definition = {
                    python = {
                        command = {"ipython"}, -- Using IPython for enhanced features
                        format = require("iron.fts.common").bracketed_paste,
                        cell = { left = "# %%", right = "" },
                        block = { left = "", right = "" },  -- Relies on indentation
                    }
                },
                repl_open_cmd = require('iron.view').split.vertical.botright(50),
            },
            ignore_blank_lines = true,
        }
    end
},
-- Indentation blankline plugin
{
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function()
        require("ibl").setup({
            scope = {
                char = "|",  -- Optional: Different character for scope lines
            },
        })
    end,
},
-- Vim BE Good game for learning vim
{
    {
        "ThePrimeagen/vim-be-good",
        -- Optional: Specify keys or events to lazy-load the plugin
        -- event = "VimEnter",  -- Load when Neovim starts
        -- cmd = "VimBeGood",   -- Load when the command is called
    }
},



-- langmapper for Arabic support (مُصحح)
{
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 1,
    config = function()
        local langmapper = require("langmapper")

        langmapper.setup({
            -- Arabic to English mapping
            default_layout = {
                [1] = {
                    id = "ar",
                    layout = "ضصثقفغعهخحجدشسيبلاتنمكطئءؤرلاىةوزظ",
                    default_layout = "qwertyuiopasdfghjklzxcvbnm"
                }
            },
            use_default_mappings = true,
            -- Apply to Normal, Visual, and Operator-pending modes only
            default_mode = { "n", "v", "o" },
            automapping = true,
        })

        -- Success message
        vim.notify("✅ langmapper loaded successfully!", vim.log.levels.INFO)

        -- Create command to check status (FIXED)
        vim.api.nvim_create_user_command("LangmapperStatus", function()
            print("🔄 Langmapper Status:")
            print("  - Plugin loaded: ✅")
            print("  - Default layout: Arabic")
            print("  - Active modes: n, v, o")

            -- Test if langmapper is working by checking if mappings exist
            local has_mappings = false
            local test_key = "ض" -- Arabic letter Dhad

            -- Check if there's a mapping for the test key
            local mappings = vim.api.nvim_get_keymap("n")
            for _, mapping in ipairs(mappings) do
                if mapping.lhs == test_key then
                    has_mappings = true
                    print("  - Test mapping (ض found): ✅")
                    break
                end
            end

            if not has_mappings then
                print("  - Test mapping: ❌ (No Arabic mappings detected)")
                print("  - Try: :lua require('langmapper').automapping()")
            end

            -- Show langmapper info if available
            pcall(function()
                local info = langmapper.get_layout_info and langmapper.get_layout_info() or "Info not available"
                print("  - Layout info: " .. tostring(info))
            end)

        end, { desc = "Check langmapper status" })

        -- Force apply mappings after setup
        vim.defer_fn(function()
            pcall(function()
                langmapper.automapping()
                vim.notify("🔄 Arabic mappings applied", vim.log.levels.INFO)
            end)
        end, 100)

    end,
},

})


