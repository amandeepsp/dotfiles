return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme kanagawa-dragon")
        end,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1001,
        config = function()
            --vim.cmd("colorscheme rose-pine")
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1002,
        config = function()
            --vim.cmd("colorscheme tokyonight")
        end,
    },
}
