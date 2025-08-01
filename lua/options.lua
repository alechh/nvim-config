vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.hidden = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.updatetime = 300
vim.o.scrolloff = 8
vim.g.mapleader = " "
vim.opt.colorcolumn = "100"
vim.o.showmode = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.syntax = off

vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "*",
  command = "silent! wall",
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("delmarks! | delmarks A-Z0-9")
  end,
})

