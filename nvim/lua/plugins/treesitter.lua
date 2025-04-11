return {
  {
    "nvim-treesitter/nvim-treesitter",  -- Treesitter configurations and abstraction layer
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")  -- Load the Treesitter configuration module
      config.setup({
        ensure_installed = { "lua", "javascript", "typescript", "html", "css", "ruby" },  -- List of languages to install parsers for
        auto_install = true,  -- Automatically install missing parsers when entering buffer
        highlight = {
          enable = true,  -- Enable syntax highlighting
          additional_vim_regex_highlighting = false,  -- Disable additional Vim regex highlighting
        },
        indent = { enable = true },  -- Enable indentation based on Treesitter
      })
      vim.keymap.set("n", "<leader>ts", ":TSPlaygroundToggle<CR>", { noremap = true, silent = true })  -- Key mapping to toggle Treesitter playground
    end
  }
}
