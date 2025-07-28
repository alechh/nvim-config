require("lazy").setup({
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "neovim/nvim-lspconfig" },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'cpp', 'c' }, -- можно добавить другие
        ignore_install = { "all" },
        highlight = {
          enable = true,              -- включить подсветку
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,              -- автодействующий отступ (не всегда идеален)
        },
        fold = {
          enable = true,
        },
      }
    end
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
        enabled = true,
        message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
        date_format = "%d.%m.%Y %H:%M:%S",
        virtual_text_column = 1,  -- virtual text start column, check Start virtual text at column section for more options
    },
  },
  {
    "nvim-telescope/telescope.nvim",
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
            "^build/",
            ".clangd/",
          }
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true,
          },
          lsp_document_symbols = {
            symbol_width = 60,
            initial_mode = "normal",
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Search in current file" })
      vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Search file names" })
      vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Search in file contents (grep)" })
      vim.keymap.set("n", "<leader>q", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Search for functions in file" })
      vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
    end,
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      vim.g.navic_silence = true
      require("nvim-navic").setup {
        highlight = true,
        separator = " > ",
        depth_limit = 5,
      }
    end
  },
  {
    "folke/tokyonight.nvim", enabled = false
  },
  { 
	"catppuccin/nvim",
	name = "catppuccin",
    priority = 1000,
	config = function()
		require('catppuccin').setup({})

		vim.cmd.colorscheme "catppuccin-frappe"
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
        start_in_insert = false,
        persist_mode = false,
        shade_terminals = true,
        })

        -- Храним все терминалы
        local terminals = {
        [1] = require("toggleterm.terminal").Terminal:new({ count = 1, direction = "horizontal", hidden = true }),
        [2] = require("toggleterm.terminal").Terminal:new({ count = 2, direction = "horizontal", hidden = true }),
        [3] = require("toggleterm.terminal").Terminal:new({ count = 3, direction = "horizontal", hidden = true }),
        [4] = require("toggleterm.terminal").Terminal:new({ count = 4, direction = "horizontal", hidden = true }),
        [5] = require("toggleterm.terminal").Terminal:new({ count = 5, direction = "horizontal", hidden = true }),
        [6] = require("toggleterm.terminal").Terminal:new({ count = 6, direction = "horizontal", hidden = true }),
        [7] = require("toggleterm.terminal").Terminal:new({ count = 7, direction = "horizontal", hidden = true }),
        [8] = require("toggleterm.terminal").Terminal:new({ count = 8, direction = "horizontal", hidden = true }),
        [9] = require("toggleterm.terminal").Terminal:new({ count = 9, direction = "horizontal", hidden = true }),
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
        vim.keymap.set("n", "<leader>4", function() toggle_only(4) end, { desc = "Терминал 4" })
        vim.keymap.set("n", "<leader>5", function() toggle_only(5) end, { desc = "Терминал 5" })
        vim.keymap.set("n", "<leader>6", function() toggle_only(6) end, { desc = "Терминал 6" })
        vim.keymap.set("n", "<leader>7", function() toggle_only(7) end, { desc = "Терминал 7" })
        vim.keymap.set("n", "<leader>8", function() toggle_only(8) end, { desc = "Терминал 8" })
        vim.keymap.set("n", "<leader>9", function() toggle_only(9) end, { desc = "Терминал 9" })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
        return {
        options = {
            theme = "catppuccin",
            icons_enabled = true,
            section_separators = { left = '', right = ''},
            component_separators = "|",
            disabled_filetypes = { "alpha", "dashboard", "neo-tree" },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location", "lsp_status" },
        },
        }
    end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
		}
	},
})
