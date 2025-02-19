local function find_python()
    local path = require("lspconfig.util").path

    -- Use active virtualenv if available
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
    end

    -- Use default system python
    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

local function on_lsp_attach(client, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    local telescope_builtin = require("telescope.builtin")
    local capabilities = client.server_capabilities

    if capabilities.definitionProvider then
        nmap("gd", telescope_builtin.lsp_definitions, "[G]oto [D]efinition")
    end

    if capabilities.declarationProvider then
        nmap("gD", telescope_builtin.lsp_declarations, "[G]oto [D]eclaration")
    end

    if capabilities.imeplementationProvider then
        nmap("gI", telescope_builtin.lsp_implementations, "[G]oto [I]mplementation")
    end

    if capabilities.referencesProvider then
        nmap("gr", telescope_builtin.lsp_references, "[G]oto [R]eferences")
    end

    if capabilities.hoverProvider then
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    end

    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    if capabilities.renameProvider then
        nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    end

    if capabilities.typeDefinitionProvider then
        nmap("<leader>D", telescope_builtin.lsp_type_definitions, "Type [D]efinition")
    end

    if capabilities.documentSymbolProvider then
        nmap("<leader>ds", telescope_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
    end

    if capabilities.workspaceSymbolProvider then
        nmap("<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    end
end

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")
            require("mason").setup()

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            local default_lsp_config = {
                capabilities = capabilities,
                on_attach = on_lsp_attach,
                flags = {
                    debounce_text_changes = 150,
                    allow_incremental_sync = true,
                },
            }

            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        lspconfig[server_name].setup(default_lsp_config)
                    end,
                    ["pyright"] = function()
                        lspconfig.pyright.setup(vim.tbl_deep_extend("force", default_lsp_config, {
                            before_init = function(_, config)
                                config.settings.python.pythonPath = find_python()
                            end,
                            on_attach = on_lsp_attach,
                        }))
                    end,
                    ["clangd"] = function()
                        lspconfig.clangd.setup(vim.tbl_deep_extend("force", default_lsp_config, {
                            cmd = {
                                "clangd",
                                "--header-insertion=never",
                                "--completion-style=detailed",
                                "--function-arg-placeholders",
                                "-j=4",
                                "--rename-file-limit=0",
                                "--background-index",
                                "--background-index-priority=normal",
                            },
                            filetypes = { "c", "cpp" },
                        }))
                    end,
                },
            })
        end,
    },
}
