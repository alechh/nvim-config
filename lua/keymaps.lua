-- Открыть дерево файлов
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })

-- Открыть новый таб
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })

-- Переключение между табами
vim.keymap.set("n", "<leader>]", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>[", ":tabprevious<CR>", { desc = "Previous tab" })

-- Закрыть текущий таб
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

vim.keymap.set('v', "<leader>k", function()
  vim.lsp.buf.format({ range = true })
end, { desc = "Format selected code" })

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set("n", "<leader>ps", function()
  local word = vim.fn.expand("<cword>")
  require("telescope.builtin").grep_string({ search = word, initial_mode = "normal" })
end, { desc = "Grep word under cursor" })

vim.keymap.set('n', '<leader>j', vim.diagnostic.open_float)

-- Не копируем старый текст после вставки нового в Visual режиме
vim.keymap.set("x", "p", [["_dP]], { noremap = true, silent = true })
