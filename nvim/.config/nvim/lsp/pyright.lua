local find_python = function()
    local path = require("lspconfig.util").path
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
    end
    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

return {
    python = {
        pythonPath = find_python(),
    },
}
