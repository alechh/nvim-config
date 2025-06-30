local navic = require("nvim-navic")

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
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>f", function()
      if vim.bo.buftype == "terminal" then vim.cmd("stopinsert") end
      require("telescope.builtin").find_files()
      end, { desc = "Find files" })
  end,
})
