require("nvim-tree").setup({
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
  renderer = {
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
})