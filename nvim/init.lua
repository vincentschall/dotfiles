vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                require("nvim-treesitter.config").setup({
                    ensure_installed = { "lua" },
                    highlight = { enable = true },
                })
            end,
        },

        {
            "mason-org/mason.nvim",
            opts = {
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            }
        },

        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000, 
            config = function()
                require("catppuccin").setup({
                    flavour = "macchiato",
                    transparent_background = false,
                    term_colors = true,
                    integrations = {
                        treesitter = true,
                        mason = true,
                    }
                })
                vim.cmd.colorscheme "catppuccin"
            end,
        },
    },
    install = { colorscheme = { "catppuccin" } },
    checker = { enabled = true },
})
