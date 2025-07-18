-- Set up lazy.nvim
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



  --telescope
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    --File tree
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

--comments
{
'terrortylor/nvim-comment',
config= function()
    require("nvim_comment").setup({ create_mappings = false })
end
},

-- multiple- cursors
  {
    "terryma/vim-multiple-cursors",
    lazy = false,  -- Load immediately (since it's a core editing plugin)
    config = function()
      -- Enable default keybindings (Ctrl+n to start)
      vim.g.multi_cursor_use_default_mapping = 1
    end
  },

  --undo tree
 {
    "mbbill/undotree",
    lazy = false, -- Load immediately (optional, if you want it available at startup)
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


})


