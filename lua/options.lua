-- الملف الخاص بالإعدادات

vim.opt.encoding = "utf-8" -- set encoding
vim.opt.nu = true -- enable line numbers
vim.opt.relativenumber = true -- relative line numbers

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.smartindent=true
vim.opt.wrap=true

vim.opt.swapfile=true
vim.opt.backup=true
vim.opt.undodir=os.getenv("HOME").."/.vim/undodir"


vim.opt.updatetime=50
vim.opt.colorcolumn="80"



vim.opt.autoindent = true -- auto indentation
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



vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.py",
  callback = function()
    vim.opt.textwidth = 79
    vim.opt.colorcolumn = "79"
  end
}) -- python formatt

local CleanOnSave = vim.api.nvim_create_augroup('CleanOnSave', {})
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  group = CleanOnSave,
  pattern = "*",
  command = [[%s/\s\+$//e]],
}) -- remove trailing whitespace from all lines before saving a file)


