local lspconfig = require("lspconfig")

local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright" },
automatic_installation = true,
})

lspconfig.pyright.setup({
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic"
      }
    }
  }
})

