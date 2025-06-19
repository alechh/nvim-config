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
