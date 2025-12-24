return {
  {
    "voldikss/vim-floaterm",
    keys = {
      { "<leader>ft", "<cmd>FloatermToggle<cr>", desc = "Toggle Floaterm" },
      { "<leader>fn", "<cmd>FloatermNew<cr>", desc = "New Floaterm" },
      { "<leader>fp", "<cmd>FloatermPrev<cr>", desc = "Previous Floaterm" },
      { "<leader>fx", "<cmd>FloatermNext<cr>", desc = "Next Floaterm" },
    },
    cmd = { "FloatermNew", "FloatermToggle", "FloatermPrev", "FloatermNext" },
    init = function()
      -- Floaterm settings
      vim.g.floaterm_width = 0.85
      vim.g.floaterm_height = 0.85
      vim.g.floaterm_title = "Terminal ($1/$2)"
      vim.g.floaterm_borderchars = "─│─│╭╮╯╰"

      -- Close floaterm with Escape key when in terminal mode
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "floaterm",
        callback = function()
          vim.keymap.set("t", "<Esc>", "<cmd>FloatermToggle<cr>", { buffer = true, desc = "Close Floaterm" })
        end,
      })
    end,
  },
}

