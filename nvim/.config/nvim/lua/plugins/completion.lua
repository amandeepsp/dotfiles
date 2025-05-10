return {
    {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        dependencies = { "rafamadriz/friendly-snippets" },
        build = vim.fn.has("win32") ~= 0 and "make install_jsregexp" or nil,
        config = function()
            require("luasnip").setup()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        dependencies = { "L3MON4D3/LuaSnip", version = "2.*" },
        version = "1.*",
        opts = {
            keymap = {
                preset = "super-tab",
            },

            appearance = {
                nerd_font_variant = "mono",
            },

            completion = {
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            snippets = { preset = "luasnip" },
            fuzzy = { implementation = "prefer_rust_with_warning" },
            signature = { enabled = true },
        },
    },
}
