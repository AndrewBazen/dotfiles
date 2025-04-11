-- lazygit.lua
-- Configuration for integrating Lazygit with Neovim

local M = {}

M.setup = function()
    -- Check if lazygit is installed
    if vim.fn.executable("lazygit") == 0 then
        vim.notify("Lazygit is not installed!", vim.log.levels.ERROR)
        return
    end

    -- Keybinding to open Lazygit
    vim.api.nvim_set_keymap(
        "n",
        "<leader>lg",
        ":lua require('plugins.lazygit').open()<CR>",
        { noremap = true, silent = true }
    )
end

M.open = function()
    -- Open Lazygit in a floating terminal
    local lazygit_cmd = "lazygit"
    local opts = {
        relative = "editor",
        width = math.floor(vim.o.columns * 0.9),
        height = math.floor(vim.o.lines * 0.9),
        row = math.floor(vim.o.lines * 0.05),
        col = math.floor(vim.o.columns * 0.05),
        style = "minimal",
        border = "rounded",
    }

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_open_win(buf, true, opts)
    vim.fn.termopen(lazygit_cmd)
    vim.cmd("startinsert")
end

return M