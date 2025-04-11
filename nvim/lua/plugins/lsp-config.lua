return {
  {
    "williamboman/mason.nvim",  -- Plugin for managing external tools like LSP servers, linters, and formatters
    lazy = false,  -- Load this plugin immediately
    build = ":MasonUpdate",  -- Command to update Mason's registry on build
    config = function()
      require("mason").setup()  -- Initialize Mason with default settings
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "tsserver", "solargraph", "html", "tailwindcss" },  -- Automatically install these LSP servers
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",  -- Plugin for configuring LSP servers installed via Mason
    dependencies = { "williamboman/mason.nvim" },  -- Dependency for Mason
    lazy = false,  -- Load this plugin immediately
    opts = {
      auto_install = true,  -- Automatically install LSP servers when needed
    },
  },
  {
    "neovim/nvim-lspconfig",  -- Core plugin for configuring Neovim's built-in LSP client
    lazy = false,  -- Load this plugin immediately
    config = function()
      -- Extend LSP client capabilities to support additional features like autocompletion
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Import the LSP configuration module
      local lspconfig = require("lspconfig")

      -- Configure Tailwind CSS LSP server
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
      })

      -- Configure TypeScript/JavaScript LSP server
      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })

      -- Configure Ruby LSP server (Solargraph)
      lspconfig.solargraph.setup({
        capabilities = capabilities,
      })

      -- Configure HTML LSP server
      lspconfig.html.setup({
        capabilities = capabilities,
      })

      -- Configure Lua LSP server
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      -- Key mappings for common LSP actions
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})  -- Show hover information
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})  -- Go to definition
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})  -- Show references
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})  -- Show code actions
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})  -- Rename symbol
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})  -- Rename symbol (alternative mapping)
    end,
  },
}
