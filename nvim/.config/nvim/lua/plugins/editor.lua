return {
    { "tpope/vim-sleuth" },
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {},
    },
    {
        "echasnovski/mini.surround",
        event = "VeryLazy",
        opts = {},
    },
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = {},
    },
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = { use_diagnostics_signs = true },
        keys = {
            {
                "<leader>xd",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "[D]ocument Diagnostics (Trouble)",
            },
            {
                "<leader>xw",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "[W]orkspace Diagnostics (Trouble)",
            },
            { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "[L]ocation List (Trouble)" },
            { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "[Q]uickfix List (Trouble)" },
        },
    },
    {
        -- Test highlighting
        -- PERF: test perf?
        -- HACK: bruh
        -- TODO: wew
        -- NOTE: sdkfj dkfjskdfj
        -- FIX: fixed
        -- WARNING: test done
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        main = "ibl",
        config = function()
            -- Don't show lines on the first indent level
            local hooks, builtin = require("ibl.hooks"), require("ibl.hooks").builtin
            hooks.register(hooks.type.WHITESPACE, builtin.hide_first_space_indent_level)
            hooks.register(hooks.type.WHITESPACE, builtin.hide_first_tab_indent_level)

            require("ibl").setup({
                indent = { char = "┊" },
                scope = {
                    enabled = true,
                },
                exclude = {
                    filetypes = {
                        "help",
                        "Trouble",
                        "trouble",
                        "lazy",
                        "mason",
                        "notify",
                    },
                },
            })
        end,
    },
}
