-- Автоустановка lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argv(0) == "" then
      vim.schedule(function()
        vim.cmd("NvimTreeOpen")
      end)
    end
  end,
})

-- Автоматически открывать NvimTree в новом табе, если он был открыт в предыдущем
local nvimtree_was_open = false

-- Следим за тем, открыт ли nvim-tree
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function(args)
    if vim.bo[args.buf].filetype == "NvimTree" then
      nvimtree_was_open = true
    end
  end,
})

-- Когда создаётся новый таб — открываем дерево, если оно было открыто
vim.api.nvim_create_autocmd("TabNewEntered", {
  callback = function()
    if nvimtree_was_open then
      vim.cmd("NvimTreeOpen")
    end
  end,
})

-- Фикс проблемы с переключениями между табами и невозможностью вводить команды
vim.api.nvim_create_autocmd("TabEnter", {
  callback = function()
    local curr_buf = vim.api.nvim_get_current_buf()
    local buftype = vim.api.nvim_buf_get_option(curr_buf, "buftype")
    local filetype = vim.api.nvim_buf_get_option(curr_buf, "filetype")

    -- Выйти из терминала
    if buftype == "terminal" then
      vim.cmd("stopinsert")
    end

    -- Если фокус на NvimTree или буфере без текста — найти первый обычный
    if filetype == "NvimTree" or buftype == "nofile" then
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buf = vim.api.nvim_win_get_buf(win)
        local bt = vim.api.nvim_buf_get_option(buf, "buftype")
        if bt == "" then
          vim.api.nvim_set_current_win(win)
          break
        end
      end
    end
  end,
})

-- Подключение конфигураций
require("options")
require("plugins")
require("keymaps")
require("lsp")
require("cmp_config")
require("nvimtree")

