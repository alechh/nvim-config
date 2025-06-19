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
    event = "VeryLazy",
    config = function()
        require("toggleterm").setup({
        size = 15,
        direction = "horizontal",
        start_in_insert = true,
        persist_mode = false,
        shade_terminals = true,
        })

        -- Храним все терминалы
        local terminals = {
        [1] = require("toggleterm.terminal").Terminal:new({ count = 1, direction = "horizontal", hidden = true }),
        [2] = require("toggleterm.terminal").Terminal:new({ count = 2, direction = "horizontal", hidden = true }),
        [3] = require("toggleterm.terminal").Terminal:new({ count = 3, direction = "horizontal", hidden = true }),
        }

        -- Функция: показать терминал X, скрыть остальные
        local function toggle_only(term_number)
        for i, term in pairs(terminals) do
            if i == term_number then
            term:toggle()
            else
            -- Скрываем все остальные, если они открыты
            if term:is_open() then
                term:close()
            end
            end
        end
        end

        -- Горячие клавиши
        vim.keymap.set("n", "<leader>1", function() toggle_only(1) end, { desc = "Терминал 1" })
        vim.keymap.set("n", "<leader>2", function() toggle_only(2) end, { desc = "Терминал 2" })
        vim.keymap.set("n", "<leader>3", function() toggle_only(3) end, { desc = "Терминал 3" })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
        return {
        options = {
            theme = "gruvbox",
            icons_enabled = true,
            section_separators = "",
            component_separators = "|",
            disabled_filetypes = { "alpha", "dashboard", "neo-tree" },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        }
    end,
    }
})
