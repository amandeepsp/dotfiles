return {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    event = "VeryLazy",
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                python = { "ruff_format", "ruff_fix" },
                lua = { "stylua" },
                sh = { "shfmt" },
                zsh = { "shfmt" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                yaml = { "yamlfix" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        })
    end,
}
