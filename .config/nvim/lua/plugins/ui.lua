return {
    "nvim-tree/nvim-web-devicons",
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({
                hijack_cursor = true,
                renderer = {
                    icons = {
                        git_placement = "signcolumn",
                    },
                },
                git = {
                    enable = true
                },
                filters = {
                    custom = { "^.git$" },
                    git_ignored = true,
                },
                diagnostics = {
                    enable = true,
                },
                actions = {
                    open_file = {
                        quit_on_open = true,
                        eject = false,
                    },
                },
            })

            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
            vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
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
