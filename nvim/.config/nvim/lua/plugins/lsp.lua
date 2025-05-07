local function on_lsp_attach(event)
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
    end

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
        return
    end

    local telescope_builtin = require("telescope.builtin")
    local capabilities = client.server_capabilities

    if not capabilities then
        return
    end

    if capabilities.definitionProvider then
        nmap("gd", telescope_builtin.lsp_definitions, "[G]oto [D]efinition")
    end

    if capabilities.declarationProvider then
        nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    end

    if capabilities.implementationProvider then
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
        nmap("gt", telescope_builtin.lsp_type_definitions, "[T]ype Definition")
    end

    if capabilities.documentSymbolProvider then
        nmap("<leader>ds", telescope_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
    end

    if capabilities.workspaceSymbolProvider then
        nmap("<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        nmap("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, "[T]oggle Inlay [h]ints")
    end
end

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")
            require("mason").setup()

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            local default_lsp_config = {
                capabilities = capabilities,
                flags = {
                    debounce_text_changes = 150,
                    allow_incremental_sync = true,
                },
            }

            require("mason-lspconfig").setup({
                automatic_enable = true,
                handlers = {
                    function(server_name)
                        lspconfig[server_name].setup(default_lsp_config)
                    end,
                },
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("nvim-lsp-attach", { clear = true }),
                callback = on_lsp_attach,
            })
        end,
    },
}
