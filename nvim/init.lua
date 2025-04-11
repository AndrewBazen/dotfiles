local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"  -- Construct the lazy.nvim path
if not vim.loop.fs_stat(lazypath) then  -- Check if the lazy.nvim directory exists
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",  -- Latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)  -- Prepend the lazy.nvim path to runtime path

require("vim-options")  -- Load Vim options from a separate file
require("lazy").setup("plugins")  -- Load plugins from a separate file
