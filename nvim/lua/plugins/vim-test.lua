return {
  "vim-test/vim-test",  -- VimTest plugin for running tests in various languages
  lazy = true,  -- Load the plugin lazily
  dependencies = {
    "preservim/vimux"  -- Vimux plugin for running tests in a terminal window
  },
  config = function()
    vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", {})  -- Key mapping to run the nearest test
    vim.keymap.set("n", "<leader>f", ":TestFile<CR>", {})  -- Key mapping to run tests in the current file 
    vim.keymap.set("n", "<leader>a", ":TestSuite<CR>", {})  -- Key mapping to run all tests in the project
    vim.keymap.set("n", "<leader>l", ":TestLast<CR>", {})  -- Key mapping to run the last test
    vim.keymap.set("n", "<leader>g", ":TestVisit<CR>", {})  -- Key mapping to visit the last test result
    vim.keymap.set("n", "<leader>o", ":TestOutput<CR>", {})  -- Key mapping to show the output of the last test
    vim.cmd("let test#strategy = 'vimux'")  -- Set the test strategy to Vimux for running tests in a terminal window
  end,
}
