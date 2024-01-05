return {
    { "folke/which-key.nvim" },
    {
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup()
        end,
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        build = ":Copilot auth",
        config = function()
            require("copilot").setup({
                -- copilot-cmp with handle these
                suggestions = { enabled = false },
                panel = { enabled = false },
            })
        end,
    },
}
