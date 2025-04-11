return {
  { 
    "hrsh7th/cmp-nvim-lsp"  -- LSP source for nvim-cmp
  },
  {  
    "L3MON4D3/LuaSnip",  -- Snippet engine
    dependencies = { 
      "saadparwaiz1/cmp_luasnip",    -- Snippet completions for nvim-cmp
      "rafamadriz/friendly-snippets", -- A collection of snippets for various languages 
    },
  },
  {
    "hrsh7th/nvim-cmp",  -- Autocompletion plugin
    config = function()
      local cmp = require("cmp")  
      require("luasnip.loaders.from_vscode").lazy_load()  -- Load snippets from friendly-snippets


      cmp.setup({
        snippet = {   
          expand = function(args)
            require("luasnip").lsp_expand(args.body)  -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),  -- Use a bordered window for completion
          documentation = cmp.config.window.bordered(),  -- Use a bordered window for documentation
        },
        mapping = cmp.mapping.preset.insert({     
          ["<C-k>"] = cmp.mapping.select_prev_item(),  -- Navigate to previous item
          ["<C-j>"] = cmp.mapping.select_next_item(),  -- Navigate to next item
          ["<C-d>"] = cmp.mapping.scroll_docs(4),  -- Scroll documentation down
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),  -- Scroll documentation up
          ["<C-Space>"] = cmp.mapping.complete(),  -- Trigger completion
          ["<C-e>"] = cmp.mapping.abort(),  -- Abort completion
          ["<CR>"] = cmp.mapping.confirm({ select = true }),  -- Confirm selection
        }),
        sources = cmp.config.sources({  
          { name = "nvim_lua" },  -- Lua completions
          { name = "path" },  -- Path completions
          { name = "buffer" },  -- Buffer completions
          { name = "calc" },  -- Calculator completions
          { name = "emoji" },  -- Emoji completions
          { name = "nvim_lsp" },  -- LSP completions
          { name = "nvim_lsp_signature_help" },  -- LSP signature help
          { name = "treesitter" },  -- Treesitter completions
          { name = "spell" },  -- Spell completions
          { name = "git" },  -- Git completions
          { name = "cmdline" },  -- Command line completions
          { name = "luasnip" }, -- For luasnip users.
        }, {
          { name = "buffer" },  
        }),
      })
    end,
  },
}
