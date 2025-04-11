local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"  -- Ensure stdpath uses correct quotes
if vim.fn.isdirectory(lazypath) == 1 then  -- Check if the directory exists (returns 1 for true)
  vim.opt.rtp:prepend(lazypath)  -- Prepend the lazy.nvim path to runtime path
else
  vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")  -- Prepend the lazy.nvim path to runtime path
end
if not vim.loop.fs_stat(lazypath) then -- Check if the lazy.nvim directory exists
  vim.fn.system({  
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)  -- Prepend the lazy.nvim path to runtime path
vim.g.mapleader = " "  -- Set the leader key to space

require("vim-options")  -- Load Vim options from a separate file
require("lazy").setup("plugins")  -- Load plugins from a separate file
