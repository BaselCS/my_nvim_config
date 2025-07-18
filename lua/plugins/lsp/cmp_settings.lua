local cmp = require("cmp")

cmp.setup({
  sources = {
    { name = "nvim_lsp", max_item_count = 5 },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
})

