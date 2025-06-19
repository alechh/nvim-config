require("lazy").setup({
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "neovim/nvim-lspconfig" },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          preview = { treesitter = false },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--no-ignore",
          },
          file_ignore_patterns = {
            "^.git/",
            "^build/CMakeFiles/",
          }
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true,
          }
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Search in current file" })
      vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Search file names" })
      vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Search in file contents (grep)" })
      vim.keymap.set("n", "<leader>q", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Search for functions in file" })
    end,
  },
  {
    "folke/tokyonight.nvim", enabled = false
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false, -- чтобы загрузить сразу
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
        transparent_mode = false,
      })
      vim.o.background = "dark"
      vim.cmd.colorscheme("gruvbox")
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 15,
        open_mapping = [[<C-\>]],
        direction = "horizontal", -- можно vertical или tab
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
      })

      -- Терминалы с номерами
      local Terminal = require("toggleterm.terminal").Terminal
      local term1 = Terminal:new({ cmd = "bash", hidden = true, direction = "horizontal" })
      local term2 = Terminal:new({ cmd = "bash", hidden = true, direction = "horizontal" })
      local term3 = Terminal:new({ cmd = "bash", hidden = true, direction = "horizontal" })

      vim.keymap.set("n", "<leader>1", function() term1:toggle() end, { desc = "Toggle Terminal 1" })
      vim.keymap.set("n", "<leader>2", function() term2:toggle() end, { desc = "Toggle Terminal 2" })
      vim.keymap.set("n", "<leader>3", function() term3:toggle() end, { desc = "Toggle Terminal 3" })
    end
  }
})
