return {
    {
        "echasnovski/mini.statusline",
        version = "*",
        dependencies = {
            "echasnovski/mini.icons",
        },
        config = function()
            require("mini.statusline").setup()
        end,
    },
    {
        "echasnovski/mini.tabline",
        version = "*",
        dependencies = {
            "echasnovski/mini.icons",
        },
        config = function()
            require("mini.tabline").setup()
        end,
    },
    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end,
    },
}
