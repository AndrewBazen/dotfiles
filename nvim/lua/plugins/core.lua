return {
  -- Set colorscheme (LazyVim default is tokyonight)
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  -- Ensure catppuccin is installed
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
}