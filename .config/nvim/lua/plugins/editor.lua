return {
    "tpope/vim-sleuth",
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        config = function()
            require("mini.pairs").setup()
        end,
    },
    {
        "echasnovski/mini.surround",
        version = "*",
        config = function()
            require("mini.surround").setup()
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
        "echasnovski/mini.hipatterns",
        version = "*",
        config = function()
            local hipatterns = require("mini.hipatterns")
            hipatterns.setup({
                highlighters = {
                    -- Highlight "FIXME", "HACK", "TODO", "NOTE"
                    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
                    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
                    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
                    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
                    hex_color = hipatterns.gen_highlighter.hex_color(),
                },
            })
        end,
    },
    {
        "echasnovski/mini.trailspace",
        version = "*",
        config = function()
            require("mini.trailspace").setup()
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup({
                indent = { char = "▏" },
                scope = { enabled = true },
                exclude = {
                    filetypes = {
                        "help",
                        "alpha",
                        "dashboard",
                        "neo-tree",
                        "Trouble",
                        "trouble",
                        "lazy",
                        "mason",
                        "notify",
                        "toggleterm",
                        "lazyterm",
                    },
                },
            })
        end,
    },
}
