local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    {
        name = "nvim_lsp",
        entry_filter = function(entry, ctx)
        -- убираем ключевое слово "else"
        return entry:get_word() ~= 'else'
        end
    },
    { name = "buffer" },
  },
})