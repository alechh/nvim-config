local navic = require("nvim-navic")

-- Функция для посветки переменной
local lspconfig = require("lspconfig")
local function setup_document_highlight_keymap(bufnr)

    vim.lsp.buf.clear_references()           -- сначала очистить старую
    vim.lsp.buf.document_highlight()         -- затем подсветить новую

  -- Автоматическое очищение при уходе курсора
  vim.api.nvim_create_autocmd("CursorMoved", {
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })
end

require("lspconfig").clangd.setup({
  cmd = {
    "clangd",
    "--background-index",
    "--compile-commands-dir=build",
    "--header-insertion=never"
  },
  root_dir = require('lspconfig.util').root_pattern(
    "build/compile_commands.json",
    "build/Makefile",
    "Makefile",
    "CMakeLists.txt"
  ),
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = true
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    local telescope = require('telescope.builtin')
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')
    vim.keymap.set("n", "gr", function()
        telescope.lsp_references({
            initial_mode = "normal",
            attach_mappings = function(_, map)
            map('n', '<CR>', function(prompt_bufnr)
                local entry = action_state.get_selected_entry()
                actions.select_default:replace(function()
                actions.close(prompt_bufnr) -- закрываем окно
                vim.cmd('edit ' .. vim.fn.fnameescape(entry.filename))
                vim.api.nvim_win_set_cursor(0, { entry.lnum, entry.col - 1 })
                end)()
            end)
            return true
            end
        })
        end
    , opts)

    vim.keymap.set("n", "<leader>f", function()
      if vim.bo.buftype == "terminal" then vim.cmd("stopinsert") end
      require("telescope.builtin").find_files()
      end, { desc = "Find files" })
	
	  vim.keymap.set("n", "<leader>h", setup_document_highlight_keymap, { buffer = bufnr, desc = "Highlight symbol under cursor" })
  end,
})
