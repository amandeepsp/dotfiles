return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "echasnovski/mini.icons",
        },
        config = function()
            require("lualine").setup({
                options = { section_separators = "", component_separators = "|" },
            })
        end,
    },
    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end,
    },
}
