return {
    { "tpope/vim-sleuth" },
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {
            mappings = {
                ["'"] = false,
                ['"'] = false,
            },
        },
        config = function(opts)
            require("mini.pairs").setup(opts)
        end,
    },
    {
        "echasnovski/mini.surround",
        event = "VeryLazy",
        config = function()
            require("mini.surround").setup()
        end,
    },
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        config = function()
            require("mini.comment").setup()
        end,
    },
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = { use_diagnostics_signs = true },
        config = function()
            require("trouble").setup()
        end,
        keys = {
            { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "[D]ocument Diagnostics (Trouble)" },
            {
                "<leader>xw",
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                desc = "[W]orkspace Diagnostics (Trouble)",
            },
            { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "[L]ocation List (Trouble)" },
            { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "[Q]uickfix List (Trouble)" },
        },
    },
    {
        -- Test highlighting
        -- PERF: test perf?
        -- HACK: bruh
        -- TODO: wew
        -- NOTE:  sdkfj dkfjskdfj
        -- FIX: fixed
        -- WARNING: test done
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup()
        end,
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
