return {
  {
    "nvim-telescope/telescope.nvim",  -- Core Telescope plugin
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            hidden = true,
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-p>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})

      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",  -- File browser extension for Telescope
    dependencies = { "nvim-telescope/telescope.nvim" },  -- Dependency on core Telescope plugin
    config = function()
      require("telescope").load_extension("file_browser")  -- Load the file browser extension
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",  -- FZF native extension for Telescope
    dependencies = { "nvim-telescope/telescope.nvim" },  -- Dependency on core Telescope plugin
    build = "make",  -- Build command for the extension
    config = function()
      require("telescope").load_extension("fzf")  -- Load the FZF extension
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",  -- UI select extension for Telescope
    dependencies = { "nvim-telescope/telescope.nvim" },  -- Dependency on core Telescope plugin
    config = function()
      require("telescope").load_extension("ui-select")  -- Load the UI select extension
    end,
  },
  {
    "nvim-telescope/telescope-symbols.nvim",  -- Symbols extension for Telescope
    dependencies = { "nvim-telescope/telescope.nvim" },  -- Dependency on core Telescope plugin
    config = function()
      require("telescope").load_extension("symbols")  -- Load the symbols extension
    end,
  },
  {
    "nvim-telescope/telescope-github.nvim",  -- GitHub extension for Telescope
    dependencies = { "nvim-telescope/telescope.nvim" },  -- Dependency on core Telescope plugin
    config = function()
      require("telescope").load_extension("gh")  -- Load the GitHub extension
    end,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",  -- Frecency extension for Telescope
    dependencies = { "nvim-telescope/telescope.nvim" },  -- Dependency on core Telescope plugin
    config = function()
      require("telescope").load_extension("frecency")  -- Load the frecency extension
    end,
  },
  {
    "nvim-telescope/telescope-project.nvim",  -- Project extension for Telescope
    dependencies = { "nvim-telescope/telescope.nvim" },  -- Dependency on core Telescope plugin
    config = function()
      require("telescope").load_extension("project")  -- Load the project extension
    end,
  },
  {
    "nvim-telescope/telescope-emoji.nvim",  -- Emoji extension for Telescope
    dependencies = { "nvim-telescope/telescope.nvim" },  -- Dependency on core Telescope plugin
    config = function()
      require("telescope").load_extension("emoji")  -- Load the emoji extension
    end,
  },
}
