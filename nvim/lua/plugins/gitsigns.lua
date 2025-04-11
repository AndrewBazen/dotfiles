return {
  {
    "tpope/vim-fugitive",  -- Git commands in nvim
    config = function()
      vim.cmd([
        nmap <leader>gs :G <CR>   -- Map <leader>gs to :G command
        nmap <leader>gc :G commit<CR>  -- Map <leader>gc to :G commit command
        nmap <leader>gp :G push<CR>  -- Map <leader>gp to :G push command
        nmap <leader>gl :G pull<CR>  -- Map <leader>gl to :G pull command
      ])
    end,
  },
  {
    "lewis6991/gitsigns.nvim",  -- Git signs in nvim
    dependencies = { "nvim-lua/plenary.nvim" },  -- Dependency for gitsigns
    event = "BufRead",  -- Load gitsigns on buffer read
    config = function()  
      require("gitsigns").setup()  -- Setup gitsigns with default configuration
      vim.cmd([
        nmap <leader>gh :Gitsigns toggle_signs<CR>   -- Map <leader>gh to toggle git signs  
        nmap <leader>gH :Gitsigns toggle_linehl<CR>  -- Map <leader>gH to toggle line highlights
        nmap <leader>gd :Gitsigns diffthis<CR>  -- Map <leader>gd to show git diff
        nmap <leader>gD :Gitsigns preview_hunk<CR>  -- Map <leader>gD to preview hunk
      ]) 
    end,
  }
}
